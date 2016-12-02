//
//  BoosterKitTests.swift
//  BoosterKitTests
//
//  Created by Travis Palmer on 10/21/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import XCTest
@testable import BoosterKit
import Quick
import Nimble
import RealmSwift

class ViewControllerSpecs: QuickSpec {
    override func spec() {
        let viewController = ViewController(coder: concreteCoder())
        
        describe("initialization") {
            it("initializes with photos") {
                expect(viewController!.objects.count).to(beGreaterThan(0))
            }
        }
    }
    
    fileprivate func concreteCoder() -> NSKeyedUnarchiver {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        
        return NSKeyedUnarchiver(forReadingWith: data as Data)
    }
}
