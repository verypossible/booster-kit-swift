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
        static let apiURL = "https://booster-kit-swift-api.herokuapp.com/api"
    }

    public class func fetchData (completionClosure: @escaping () -> Void) {
        Alamofire.request("\(Constants.apiURL)/photos").responseArray { (response: DataResponse<[Photo]>) in
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

    public class func authenticateUser (
        email: String,
        password: String,
        passwordConfirmation: String,
        completionClosure: @escaping () -> Void) {
        let parameters = [
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation
        ]

        Alamofire.request(
            "\(Constants.apiURL)/auth/sign_in",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
            ).validate()
            .responseJSON { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.response?.description ?? "")")
                switch response.result {
                case .success:
                    completionClosure()
                case .failure(let error):
                    print(error)
                }
        }
    }
}
