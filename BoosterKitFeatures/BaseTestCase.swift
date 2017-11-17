//
//  BaseTestCase.swift
//  BoosterKit
//
//  Created by Travis Palmer on 8/4/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

import Foundation
import UIKit
import KIF
import RealmSwift

class BaseTestCase: KIFTestCase {
    override func beforeEach() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

        super.beforeEach()
    }

    override func afterEach() {
        returnToRootViewController()
    }

    func returnToRootViewController() {
        guard let navigation = UIApplication.shared.keyWindow!.rootViewController as? UINavigationController else {
            NSException.raise(
                NSExceptionName.genericException,
                format: "Failed to assign root view controller",
                arguments: getVaList([])
            )
            return
        }

        navigation.popToRootViewController(animated: false)
    }

    func loginUser() {
        guard let navigation = UIApplication.shared.keyWindow!.rootViewController as? UINavigationController else {
            NSException.raise(
                NSExceptionName.genericException,
                format: "Failed to assign root view controller",
                arguments: getVaList([])
            )
            return
        }
        navigation.popToRootViewController(animated: false)

        viewTester().usingLabel("loginEmail").clearAndEnterText("travis@verypossible.com")
        viewTester().usingLabel("loginPassword").clearAndEnterText("testington")
        viewTester().usingLabel("loginPasswordConfirm").clearAndEnterText("testington")

        viewTester().usingLabel("Login").tap()
    }
}
