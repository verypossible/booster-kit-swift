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

class PhotosViewControllerMock: PhotosViewController {
    var performedSeugeIdentifier: String?

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        performedSeugeIdentifier = identifier
    }
}

class PhotosViewControllerSpecs: BaseSpec {
    override func spec() {
        var viewController: PhotosViewController!

        beforeEach {
            viewController = UIStoryboard(
                name: "Main",
                bundle: nil).instantiateViewController(
                    withIdentifier: "PhotosViewController"
                ) as? PhotosViewController

            // IBOutlets are nil unless loadView() is called.
            viewController.loadView()

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
            describe("didSelectRowAtIndexPath") {
                beforeEach {
                    viewController.viewDidLoad()
                }

                it("sets the selectedCellIndex") {
                    expect(viewController.selectedCellIndex).to(equal(0))

                    viewController.tableView(
                        viewController.tableView,
                        didSelectRowAt: IndexPath(row: 2, section: 0)
                    )

                    expect(viewController.selectedCellIndex).to(equal(2))
                }

                it("performs a segue to the detail view") {
                    let photosVCMock = PhotosViewControllerMock(coder: self.concreteCoder())!

                    photosVCMock.tableView(
                        UITableView(),
                        didSelectRowAt: IndexPath(row: 2, section: 0)
                    )

                    expect(photosVCMock.performedSeugeIdentifier).to(
                        equal(PhotosViewController.Constants.photoDetailSegueId)
                    )
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
