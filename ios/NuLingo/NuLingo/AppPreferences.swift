//
//  AppPreferences.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import UIKit
import SwiftUI

class AppPreferences: NSObject {
    static let shared = AppPreferences()
    
    var loggedIn: Bool = UserDefaults.standard.bool(forKey: "logged_in")
    
    override init() {
        
    }
}
