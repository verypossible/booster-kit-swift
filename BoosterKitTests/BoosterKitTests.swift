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
        let viewController = PhotosViewController(coder: concreteCoder())
        
        describe("initialization") {
            it("initializes") {
                //TODO: This test is pretty useless since the compiler is doing the same thing 
                expect(viewController!.selectedCellIndex).to(equal(0))
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
