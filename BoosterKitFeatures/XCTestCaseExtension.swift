//
//  XCTestCaseExtension.swift
//  BoosterKitUITests
//
//  Created by Travis Palmer on 11/11/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import XCTest
import KIF

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
