//
//  PhotosViewControllerTests.swift
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
import Nocilla

class PhotosViewControllerSpecs: QuickSpec {
//    override func setUp() {
//        super.setUp()
//        
//        LSNocilla.sharedInstance().start()
//    }
    
//    override func tearDown() {
//        LSNocilla.sharedInstance().stop()
//        
//        super.tearDown()
//    }
    
    override func spec() {
        LSNocilla.sharedInstance().start()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        
        stubRequest("GET", "https://static.realm.io/update/cocoa?2.4.2" as LSMatcheable!)
        stubRequest("GET", "https://api.mixpanel.com/track".regex())
        
        let stubbedJSON = "{\"values\" : {\"viewed\" : true} }" as LSHTTPBody
        let stubbedHeaders = NSDictionary(dictionary: ["Accept-Encoding": "gzip;q=1.0, compress;q=0.5", "Accept-Language": "en;q=1.0", "User-Agent": "BoosterKit/1.0 (spartan.BoosterKit; build:1; iOS 10.2.0) Alamofire/4.0.1"]) as! [String: String]
//        stubRequest("GET", "https://jsonplaceholder.typicode.com/photos".regex()).withHeaders(stubbedHeaders).andReturn(200).withHeaders(["Content-Type": "application/json"]).withBody(stubbedJSON)
        stubRequest("GET", "https://jsonplaceholder.typicode.com/photos" as LSMatcheable!)
        
//        describe("initialization") {
//            let realm = try! Realm()
//            try! realm.write {
//                realm.create(Photo.self, value: ["id": 0, "title": "test photo", "thumbnailUrl": "http://test.com"])
//                realm.create(Photo.self, value: ["id": 1, "title": "test photo 2", "thumbnailUrl": "http://test.com"])
//                realm.create(Photo.self, value: ["id": 2, "title": "test photo 3", "thumbnailUrl": "http://test.com"])
//            }
//            
//            let viewController = PhotosViewController(coder: concreteCoder())
//            
//            it("initializes photos") {
//                expect(viewController!.photos.count).to(equal(3))
//            }
//        }
        
        describe("viewDidLoad") {
//            let stubbedJSON = "{\"values\" : {\"viewed\" : true} }" as LSHTTPBody
//            let stubbedHeaders = NSDictionary(dictionary: ["Accept-Encoding": "gzip;q=1.0, compress;q=0.5", "Accept-Language": "en;q=1.0", "User-Agent": "BoosterKit/1.0 (spartan.BoosterKit; build:1; iOS 10.2.0) Alamofire/4.0.1"]) as! [String: String]
//                
            
//                NSDictionary(dictionary:["person": ["name": "Dani","age": "24"]]) as! LSHTTPBody
            
//            stubRequest("GET", "https://jsonplaceholder.typicode.com/photos" as LSMatcheable!)
//            stubRequest("GET", "https://jsonplaceholder.typicode.com/photos" as LSMatcheable!).withHeaders(["Accept-Encoding": "gzip;q=1.0, compress;q=0.5", "Accept-Language": "en;q=1.0", "User-Agent": "BoosterKit/1.0 (spartan.BoosterKit; build:1; iOS 10.2.0) Alamofire/4.0.1"])
//            stubRequest("GET", "https://jsonplaceholder.typicode.com/photos".regex()).withHeaders(stubbedHeaders).andReturn(200).withHeaders(["Content-Type": "application/json"]).withBody(stubbedJSON)
            
            it("fetches data from the API") {
                let viewController = PhotosViewController(coder: self.concreteCoder())!
                
//                viewController.viewDidLoad()
                
                expect(viewController.photos.count).to(equal(4))
            }
        }
        LSNocilla.sharedInstance().stop()
    }
    
    fileprivate func concreteCoder() -> NSKeyedUnarchiver {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        
        return NSKeyedUnarchiver(forReadingWith: data as Data)
    }
}
