//
//  LoginViewController.swift
//  BoosterKit
//
//  Created by Travis Palmer on 1/13/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

class LoginViewController: UIViewController, UITextFieldDelegate {

    var APIManagerClass: APIManagerProtocol = APIManager()

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmationTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    @IBAction func loginButtonPressed () {
        if emailTextField.text!.isEmpty &&
           passwordTextField.text!.isEmpty &&
           passwordConfirmationTextField.text!.isEmpty {

            return
        }

        // We're using the trailing closure syntax here:
        // http://tinyurl.com/gnm3noo
        type(of: APIManagerClass).authenticateUser(
            email: emailTextField.text!,
            password: passwordTextField.text!,
            passwordConfirmation: passwordConfirmationTextField.text!) {

                logger.info("Successfully authenticated!")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                APIManager.fetchData {}
        }
    }

    // Called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // Called when the user clicks on the view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
