//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 06/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func loginButtonAction() {
        view.endEditing(true)
        self.initLogin()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    

    // MARK: - UI Functions
    
    private func setupUI() {
        
        // Sign up button borde radius 25
        self.loginButton.layer.cornerRadius = 16
    }
    
    // MARK: - Logic functions
    
    private func initLogin() {
        // Check if email exists
        guard let email = emailTextField.text, !email.isEmpty else {
            return NotificationBanner(title: "Error", subtitle: "Debes especificar un correo electrónico",  style: .warning).show()
        }
        
        // Check if password exists
        guard let pwd = pwdTextField.text, !pwd.isEmpty else {
            return NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña",  style: .warning).show()
        }
        
        // Make login
        self.login(email, pwd)
    }
    
    private func login(_ email: String, _ pwd: String) {
        
        // Create LoginRequest Struct
        let loginStruct = LoginRequest(email: email, password: pwd)
        
        // Init spinner
        SVProgressHUD.show()
        
        // Make the request to server
        SN.post(endpoint: Endpoints.login, model: loginStruct) { (response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
            
            // Stop spinner
            SVProgressHUD.dismiss()
            
            // Handle response
            switch response {
            case .error(let error):
                // Unhandle error
                print(error)
                return NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger).show()
            case .errorResult(let error):
                // Handled error from server
                return NotificationBanner(title: "Error", subtitle: error.error, style: .warning).show()
            case .success(let response):
                print(response)
                self.performSegue(withIdentifier: "showHome", sender: nil)
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: response.token)
                break
            }
        }
    }
    

}
