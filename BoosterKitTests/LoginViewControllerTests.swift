//
//  LoginViewControllerTests.swift
//  BoosterKitTests
//
//  Created by Daniel Bergquist on 12/15/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

import XCTest
@testable import BoosterKit
import Quick
import Nimble
import RealmSwift
import Nocilla
import SwiftyMocky

class LoginViewControllerSpecs: QuickSpec {
    override func spec() {
        LSNocilla.sharedInstance().start()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

        describe("loginButtonPressed") {

            let viewController: LoginViewController! = UIStoryboard(
                name: "Main",
                bundle: nil).instantiateViewController(
                    withIdentifier: "LoginViewController"
                ) as? LoginViewController

            it("authenticates with the API") {

                viewController.loadView()

                let email = "very@verypossible.com"
                let password = "sdofijasdf"
                let mock = APIManagerProtocolMock()

                viewController.APIManagerClass = mock
                viewController.emailTextField.text = email
                viewController.passwordTextField.text = password
                viewController.passwordConfirmationTextField.text = password

                viewController.loginButtonPressed()

                Verify(APIManagerProtocolMock.self, 1, .authenticateUser(email: .any,
                                                                         password: .any,
                                                                         passwordConfirmation: .any,
                                                                         completionClosure: .any
                    ))

                Verify(APIManagerProtocolMock.self, 1, .authenticateUser(email: .value(email),
                                                                         password: .value(password),
                                                                         passwordConfirmation: .value(password),
                                                                         completionClosure: .any
                    ))
            }
        }
    }
}
