//
//  APIManagerTests.swift
//  BoosterKit
//
//  Created by Travis Palmer on 6/30/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

import XCTest
@testable import BoosterKit
import Quick
import Nimble
import RealmSwift
import Nocilla

class APIManagerSpecs: QuickSpec {
    override func spec() {
        LSNocilla.sharedInstance().start()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

        describe("fetchData") {
            it("persists photos") {
                let stubbedBody =
                    "[{\"id\": 1, \"albumId\": 1, \"title\": \"photo 1\"," +
                    "\"url\": \"someUrl\", \"thumbnailUrl\": \"anotherUrl\"}," +
                    "{\"id\": 2, \"albumId\": 2, \"title\": \"photo 2\"," +
                    "\"url\": \"someUrl\", \"thumbnailUrl\": \"anotherUrl\"}," +
                    "{\"id\": 3, \"albumId\": 3, \"title\": \"photo 3\"," +
                    "\"url\": \"someUrl\", \"thumbnailUrl\": \"anotherUrl\"}]"

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
        }

        LSNocilla.sharedInstance().stop()
    }
}
