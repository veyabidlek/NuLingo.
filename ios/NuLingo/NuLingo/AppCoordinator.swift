//
//  AppCoordinator.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import Foundation
import UIKit
import SwiftUI

public protocol AppCoordinatorProtocol: AnyObject {
    func start()
}

final class AppCoordinator: NSObject, AppCoordinatorProtocol {
    let loginNvc = UINavigationController()
    let mainNvc = UINavigationController()
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.left"), transitionMaskImage: UIImage(systemName: "chevron.left"))
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .darkGray
        window.makeKeyAndVisible()
    }
    
    
    func start() {
        if !UserDefaults.standard.bool(forKey: "hide_onboarding") {
            startOnboardingFlow()
        } else {
            startMainFlow()
        }
    }
    
    func startOnboardingFlow() {
        let vc = OnboardingView(completion: { [weak self] in
            guard let self else { return }
            UserDefaults.standard.set(true, forKey: "hide_onboarding")
            self.start()
        }).wrapped
        self.window.rootViewController = vc
    }
    
    func startMainFlow() {
        let router = MainRouter(nvc: mainNvc)
        mainNvc.pushViewController(MainView(router: router).wrapped, animated: true)
        self.window.rootViewController = mainNvc
    }
}

