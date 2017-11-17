//
//  BaseSpec.swift
//  BoosterKitTests
//
//  Created by Travis Palmer on 11/17/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

@testable import BoosterKit
import Quick
import Nimble
import RealmSwift
import Nocilla

class BaseSpec: QuickSpec {
    override func spec() {
        beforeSuite {
            LSNocilla.sharedInstance().start()
            self.defineGlobalStubs()
        }

        afterSuite {
            LSNocilla.sharedInstance().stop()
        }

        beforeEach {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }
    }

    func defineGlobalStubs () {
        stubRequest("GET", "https://static.realm.io".regex())
        stubRequest("GET", "https://api.mixpanel.com".regex())
    }
}
