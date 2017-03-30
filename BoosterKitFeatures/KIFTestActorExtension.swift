//
//  KIFTestActorExtension.swift
//  BoosterKitUITests
//
//  Created by Travis Palmer on 2/13/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

import KIF

extension KIFTestActor {
    func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
