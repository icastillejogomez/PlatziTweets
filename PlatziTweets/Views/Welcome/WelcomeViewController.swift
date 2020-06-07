//
//  WelcomeViewController.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 06/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    

    // MARK: - UI Functions
    
    private func setupUI() {
        
        // Sign up button borde radius 25
        self.signUpButton.layer.cornerRadius = 25
    }

}
