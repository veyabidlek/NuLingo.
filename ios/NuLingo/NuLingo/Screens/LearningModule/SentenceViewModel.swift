import SwiftUI
import UIKit

import AVFoundation

struct TTSResponse: Codable {
    var audio: String
}

struct SentenceCategory: Codable {
    var category_name: String
    var sentences: [[String]]
    var _id: String?
}

struct Sentence: Identifiable {
    var id = UUID()
    
    var kazakh: String
    var russian: String
    var english: String
    var turkish: String
}

enum Category: String, Equatable, Hashable, CaseIterable {
    case animals
    case family
    case religion
    case activity
    case finance
    case technology
    case food
    case sport
    case drinks
    case generate_random
}

class SentenceViewModel: ObservableObject {
    static let shared = SentenceViewModel()
    private var audioPlayer: AVAudioPlayer?
    
    @Published var sentences: [Category: [Sentence]] = [:]
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var postId: String = ""
    
    func postCategory(accessToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://batyr-ftd4d4hudqfpagap.westus-01.azurewebsites.net/api/generate-category") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any?] = [
            "text_prompt": "general_phrases",
            "file_prompt": nil
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = "HTTP Error: \(response?.description ?? "Unknown")"
                completion(.failure(NSError(domain: errorMessage, code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data returned", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(SentenceCategory.self, from: data)
                completion(.success(apiResponse._id!))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetch() {
        for category in Category.allCases {
            fetchSentences(for: category, accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI")
        }
    }
    
    func fetchSentences(for category: Category, accessToken: String? = nil) {
        if sentences[category]?.isEmpty == false {
            return // Already loaded
        }
        
        self.isLoading = true
        
        if category == .generate_random {
            // Request for random category generation
            guard let accessToken = accessToken else { return }
            postCategory(accessToken: accessToken) { [weak self] result in
                switch result {
                case .success(let responseString):
                    self?.postId = responseString
                    self?.loadSentences(for: .generate_random)  // Now load the sentences
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                        self?.isLoading = false
                    }
                }
            }
        } else {
            loadSentences(for: category)
        }
    }
    
    private func loadSentences(for category: Category) {
        let query = category == .generate_random ? "categories/\(postId)" : category.rawValue
        
        guard let url = URL(string: "https://batyr-ftd4d4hudqfpagap.westus-01.azurewebsites.net/api/\(query)") else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let categoryData = try decoder.decode(SentenceCategory.self, from: data)
                
                DispatchQueue.main.async {
                    self.sentences[category] = categoryData.sentences.map { sentence in
                        Sentence(
                            kazakh: sentence[0],
                            russian: sentence[1],
                            english: sentence[2],
                            turkish: sentence[3]
                        )
                    }
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
