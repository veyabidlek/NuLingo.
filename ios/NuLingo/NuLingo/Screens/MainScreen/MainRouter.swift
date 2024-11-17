//
//  MainRouter.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 17.11.2024.
//

import UIKit
import SwiftUI

final class MainRouter: NSObject {
    private var nvc: UINavigationController
    
    init(nvc: UINavigationController) {
        self.nvc = nvc
        
        super.init()

        self.customizeBar()
    }
    
    func customizeBar() {
//        nvc.navigationBar.isHidden = false
//        
//        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"))
//        
//        let titleButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"))
//        
//        let profileButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"))
//        
//        nvc.navigationItem.leftBarButtonItem = menuButton
//        nvc.navigationItem.rightBarButtonItem = profileButton
//        nvc.navigationItem.title = "titleButton"
//        
//        nvc.navigationBar.setNeedsLayout()
//        nvc.navigationBar.layoutIfNeeded()
    }
    
    @objc
    func openProfile() {
        
    }
    
    func openLanguageView(language: Language) {
        let cardNames: [Language: String] = [
            .kazakh: "Kazakh 🇰🇿",
            .turkish: "Turkish 🇹🇷",
            .russian: "Russian 🇷🇺"
        ]
        let vc = LanguageView(router: self, language: language, cardNames: cardNames).wrapped
        nvc.pushViewController(vc, animated: true)
    }
    
//    func openFlashcardView(categoryTitle: String) {
////        let vc = Alert(title: Text("Soon..."), primaryButton: .cancel(), secondaryButton: .default(Text("Done")))
////        nvc.pushViewController(vc, animated: true)
////    }

    
    func openSentenceView(language: Language, category: String, categoryTitle: String) {
        let group = DispatchGroup()
        let vc = SentenceView(group: group, language: language, category: category, categoryTitle: categoryTitle).wrapped
        nvc.pushViewController(vc, animated: true)
    }
}
