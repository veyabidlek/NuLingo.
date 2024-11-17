import SwiftUI

class UserPreferences: ObservableObject {
    static let shared = UserPreferences()

    private init() { }
    
    @AppStorage("show_onboarding") public var showOnboarding = true
}
