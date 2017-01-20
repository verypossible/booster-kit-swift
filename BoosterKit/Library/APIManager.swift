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
        static let apiURL = "https://jsonplaceholder.typicode.com"
    }
    
    public class func fetchData (completionClosure: @escaping () -> ()) {
        Alamofire.request("\(Constants.apiURL)/photos").responseArray { (response: DataResponse<[Photo]>) in
            let photoArray = response.result.value! as [Photo]
            
            DispatchQueue.global(qos: .background).async {
                // Get realm and table instances for this thread.
                let realm = try! Realm()
                
                realm.beginWrite()
                
                for photo in photoArray {
                    NSLog("Photo \(photo)")
                    realm.add(photo, update: true)
                }
                
                do {
                    NSLog("Saving photos.")
                    try realm.commitWrite()
                } catch {
                    NSLog("Failed saving photos!")
                }
                
                DispatchQueue.main.async {
                    // Run any passed completion closure in the main thread.
                    completionClosure()
                }
            }
        }
    }
    
    public class func authenticateUser (email: String, password: String, completionClosure: @escaping () -> ()) {
        let parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request("\(Constants.apiURL)/auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.response)")
                switch response.result {
                case .success:
                    completionClosure()
                case .failure(let error):
                    print(error)
                }
        }
    }
}
