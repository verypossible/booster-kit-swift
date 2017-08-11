//
//  PhotosViewControllerFeatures.swift
//  BoosterKitUITests
//
//  Created by Travis Palmer on 2/13/17.
//  Copyright © 2017 Spartan. All rights reserved.
//

class PhotosViewControllerFeatures: BaseTestCase {
    override func beforeEach() {
        loginUser()
    }

    func testPresenceOfPhotoViews() {
        viewTester().usingLabel("Photos View").waitForView()
        viewTester().usingLabel("Photos List").waitForView()
        viewTester().usingLabel("Photos List").tapRowInTableView(at: IndexPath(row: 1, section: 0))
        viewTester().usingLabel("Photo Detail").waitForView()
    }
}
