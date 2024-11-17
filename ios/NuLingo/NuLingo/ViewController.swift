//
//  ViewController.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import UIKit

class ViewController: UIViewController {
    init() {
        print("inited")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view background color
        view.backgroundColor = .white
        
        // Set up the label
        setupLabel()
    }
    
    // MARK: - UI Setup
    private func setupLabel() {
        let label = UILabel()
        label.text = "MainSCreen broo"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        // Center the label within the view
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

