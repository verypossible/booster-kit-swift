//
//  AppDelegate.swift
//  BoosterKit
//
//  Created by Travis Palmer on 10/21/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        BuddyBuildSDK.setup()
        
        NSLog("Realm DB: \(Realm.Configuration.defaultConfiguration.fileURL)")
        
        let realm = try! Realm()
        
        if realm.objects(Photo.self).count == 0 {
            // Fetch data from sample API.
            DispatchQueue.global(qos: .background).async {
                let URL = "http://jsonplaceholder.typicode.com/photos"
                Alamofire.request(URL).responseArray { (response: DataResponse<[Photo]>) in
                    let photoArray = response.result.value! as [Photo]
                    for photo in photoArray {
                        try! realm.write{
                            NSLog("Saving Photo \(photo)")
                            realm.add(photo, update: true)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    print("We probably want to reload the tableview here.")
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

