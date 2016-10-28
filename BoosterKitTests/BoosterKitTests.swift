//
//  BoosterKitTests.swift
//  BoosterKitTests
//
//  Created by Travis Palmer on 10/21/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import XCTest
@testable import ViewController
import Quick
import Nimble


class ViewControllerSpecs: QuickSpec {
    
    override func spec() {
        let viewController = ViewController()
        
        describe("initialization") {
            it("initializes with seed data") {
                expect(viewController!.objects.counts).to(equal(3))
            }
        }
    }
}
