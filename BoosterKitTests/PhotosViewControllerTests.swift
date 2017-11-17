//
//  PhotosViewControllerTests.swift
//  BoosterKitTests
//
//  Created by Travis Palmer on 10/21/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

@testable import BoosterKit
import Quick
import Nimble
import RealmSwift
import Nocilla

class PhotosViewControllerSpecs: BaseSpec {
    override func spec() {
        var viewController: PhotosViewController!

        beforeEach {
            viewController = PhotosViewController(coder: self.concreteCoder())

            // swiftlint:disable:next force_try
            let realm = try! Realm()
            // swiftlint:disable:next force_try
            try! realm.write {
                realm.deleteAll()
                realm.create(Photo.self, value: [
                    "photoId": 0,
                    "title": "test photo",
                    "thumbnailUrl": "http://test.com"
                    ])
                realm.create(Photo.self, value: [
                    "photoId": 1,
                    "title": "test photo 2",
                    "thumbnailUrl": "http://test.com"
                    ])
                realm.create(Photo.self, value: [
                    "photoId": 2,
                    "title": "test photo 3",
                    "thumbnailUrl": "http://test.com"
                    ])
            }
        }

        describe("initialization") {
            it("initializes photos") {
                expect(viewController!.photos.count).to(equal(3))
            }
        }

        context("UITableViewDelegate methods") {
//            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                self.selectedCellIndex = indexPath.row
//                self.performSegue(withIdentifier: Constants.photoDetailSegueId, sender: self)
//            }
            describe("didSelectRowAt") {
                it("sets the selectedCellIndex") {

                }

                it("performs a segue to the detail view") {

                }
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
