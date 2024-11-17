//
//  UINavigationController+Extension.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 17.11.2024.
//

import UIKit
import SwiftUI

extension UINavigationBar {
    func setStyle(primaryColor: UIColor, titleColor: UIColor, lightContent: Bool = false, transparent: Bool) {
        self.tintColor = titleColor
        self.isTranslucent = transparent
        UINavigationBar.appearance().tintColor = titleColor
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            
            if transparent {
                appearance.configureWithTransparentBackground()
            } else {
                appearance.configureWithOpaqueBackground()
            }
            
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            appearance.backgroundColor = primaryColor
            
            self.standardAppearance = appearance
            self.scrollEdgeAppearance = appearance
        } else {
            self.titleTextAttributes = [.foregroundColor: titleColor]
            self.barTintColor = primaryColor
        }
        
        UIApplication.shared.setStatusBarStyle(lightContent ? .lightContent : .default, animated: true)
    }
}
