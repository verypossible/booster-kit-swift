//
//  LoginViewController.swift
//  BoosterKit
//
//  Created by Travis Palmer on 1/13/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func loginButtonPressed () {
        
        // We're using the trailing closure syntax here:
        // http://tinyurl.com/gnm3noo
        APIManager.authenticateUser(email: emailTextField.text!, password: passwordTextField.text!) {
            NSLog("Successfully authenticated!")
        }
    }
}
