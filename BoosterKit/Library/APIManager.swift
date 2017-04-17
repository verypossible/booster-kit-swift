//
//  APIManager.swift
//  BoosterKit
//
//  Created by Travis Palmer on 12/16/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class APIManager {

    struct Constants {
        static let apiURL = "https://jsonplaceholder.typicode.com/photos"
    }

    public class func fetchData (completionClosure: @escaping () -> Void) {
        Alamofire.request(Constants.apiURL).responseArray { (response: DataResponse<[Photo]>) in
            let photoArray = response.result.value! as [Photo]

            DispatchQueue.global(qos: .background).async {
                // Get realm and table instances for this thread.
                // swiftlint:disable:next force_try
                let realm = try! Realm()

                realm.beginWrite()

                for photo in photoArray {
                    logger.debug("Photo \(photo)")
                    realm.add(photo, update: true)
                }

                do {
                    logger.debug("Saving photos.")
                    try realm.commitWrite()
                } catch {
                    logger.error("Failed saving photos!")
                }

                DispatchQueue.main.async {
                    // Run any passed completion closure in the main thread.
                    completionClosure()
                }
            }
        }
    }
}
