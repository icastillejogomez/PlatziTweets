//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Ignacio F. Castillejo Gómez on 06/06/2020.
//  Copyright © 2020 Ignacio F. Castillejo Gómez. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwd2TextField: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func signUpAction() {
        view.endEditing(true)
        self.initSignUp()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    // MARK: - UI Functions
    
    private func setupUI() {
        
        // Sign up button borde radius 25
        self.signUpButton.layer.cornerRadius = 16
    }
    
    // MARK: - Logic functions
    
    private func initSignUp() {
        // Check if name exists
        guard let name = nameTextField.text, !name.isEmpty else {
            return NotificationBanner(title: "Error", subtitle: "Debes indicar tu nombre",  style: .warning).show()
        }
        
        // Check if email exists
        guard let email = emailTextField.text, !email.isEmpty else {
            return NotificationBanner(title: "Error", subtitle: "Debes especificar un correo electrónico",  style: .warning).show()
        }
        
        // Check if password exists
        guard let pwd = pwdTextField.text, !pwd.isEmpty else {
            return NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña",  style: .warning).show()
        }
        
        // Check if password 2 exists
        guard let pwd2 = pwd2TextField.text, !pwd2.isEmpty else {
            return NotificationBanner(title: "Error", subtitle: "Debes repetir la contraseña",  style: .warning).show()
        }
        
        // Check if password has less than 4 characters
        if pwd != pwd2 {
            return NotificationBanner(title: "Error", subtitle: "Las contraseñas no coinciden", style: .danger).show()
        }
        
        // Create new account
        self.createAccount(name: name, email: email, pwd: pwd)
    }
    
    private func createAccount(name: String, email: String, pwd: String) {
        
        // Create LoginRequest Struct
        let registerStruct = RegisterRequest(email: email, password: pwd, names: name)
        
        // Init spinner
        SVProgressHUD.show()
        
        // Make the request to server
        SN.post(endpoint: Endpoints.register, model: registerStruct) { (response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
            
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
