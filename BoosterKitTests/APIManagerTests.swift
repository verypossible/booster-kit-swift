//
//  APIManagerTests.swift
//  BoosterKit
//
//  Created by Travis Palmer on 6/30/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

@testable import BoosterKit
import Quick
import Nimble
import RealmSwift
import Nocilla
import KeychainAccess

class APIManagerSpecs: BaseSpec {
    override func spec() {
        describe("fetchData") {
            it("persists photos") {
                
                let stubbedBody = """
                    [
                     {"id": 1, "albumId": 1, "title": "photo 1", "url": "someUrl", "thumbnailUrl": "anotherUrl"},
                     {"id": 2, "albumId": 2, "title": "photo 2", "url": "someUrl", "thumbnailUrl": "anotherUrl"},
                     {"id": 3, "albumId": 3, "title": "photo 3", "url": "someUrl", "thumbnailUrl": "anotherUrl"}
                    ]
                   """

                // We don't care about the return value here, hence the weird _ = syntax.
                _ = stubRequest("GET",
                    "https://booster-kit-swift-api.herokuapp.com/api/photos/index" as LSMatcheable)
                    .andReturn(200)
                    .withBody(stubbedBody as LSHTTPBody)

                var photoCount = 0
                APIManager.fetchData {
                    // swiftlint:disable:next force_try
                    photoCount = try! Realm().objects(Photo.self).count
                }

                expect(photoCount).toEventually(equal(3))
            }
        }

        describe("authenticateUser") {
            it("authenticates a user and saves session data to the keychain") {

                keychain["Access-Token"] = nil
                keychain["Client"] = nil
                keychain["Uid"] = nil

                let authHeaders = [
                    "Access-Token": "secrettoken",
                    "Client": "clientid",
                    "Uid": "test@verypossible.com"
                ]
                let authBody = """
                    {
                     "data": {
                        "id":1,
                        "email":"test@verypossible.com",
                        "provider":"email",
                        "uid":"test@verypossible.com",
                        "name":null,
                        "nickname":null,
                        "image":null
                     }
                    }
                   """

                // We don't care about the return value here, hence the weird _ = syntax.
                _ = stubRequest("POST",
                    "https://booster-kit-swift-api.herokuapp.com/api/auth/sign_in" as LSMatcheable)
                    .andReturn(200)
                    .withHeaders(authHeaders)
                    .withBody(authBody as LSHTTPBody)

                APIManager.authenticateUser(
                    email: "test@verypossible.com",
                    password: "password",
                    passwordConfirmation: "password") {}

                expect(keychain["Access-Token"]).toEventually(equal("secrettoken"))
                expect(keychain["Client"]).toEventually(equal("clientid"))
                expect(keychain["Uid"]).toEventually(equal("test@verypossible.com"))
            }
        }
    }
}
