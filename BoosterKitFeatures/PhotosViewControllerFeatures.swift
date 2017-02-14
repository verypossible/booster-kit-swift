//
//  PhotosViewControllerFeatures.swift
//  BoosterKitUITests
//
//  Created by Travis Palmer on 2/13/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

import UIKit
import KIF

class PhotosViewControllerFeatures: KIFTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresenceOfPhotoList() {
        tester().waitForView(withAccessibilityLabel: "Photo List")
    }
}
