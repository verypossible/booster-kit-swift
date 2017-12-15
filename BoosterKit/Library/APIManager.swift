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

//sourcery: AutoMockable
protocol APIManagerProtocol {

    static func fetchData(completionClosure: @escaping () -> Void)

    static func authenticateUser(email: String,
                                 password: String,
                                 passwordConfirmation: String,
                                 completionClosure: @escaping () -> Void)
}

class APIManager: APIManagerProtocol {

    struct Constants {
        static let apiURL = "https://booster-kit-swift-api.herokuapp.com/api"
    }

    public class func fetchData (completionClosure: @escaping () -> Void) {
        let headers: HTTPHeaders = [
            "Access-Token": keychain["Access-Token"] ?? "",
            "Client": keychain["Client"] ?? "",
            "Uid": keychain["Uid"] ?? ""
        ]

        Alamofire.request(
            "\(Constants.apiURL)/photos/index",
            headers: headers).responseArray { (response: DataResponse<[Photo]>) in

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
                    NotificationCenter.default.post(
                        name: Notification.Name("PhotosChanged"),
                        object: self
                    )
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
                logger.debug("Sign In: \(response.result.isSuccess)")
                switch response.result {
                case .success:
                    if let headers = response.response?.allHeaderFields as? [String: String] {
                        keychain["Access-Token"] = headers["Access-Token"]
                        keychain["Client"] = headers["Client"]
                        keychain["Uid"] = headers["Uid"]
                    }
                    completionClosure()
                case .failure(let error):
                    logger.error(error)
                }
        }
    }
}
