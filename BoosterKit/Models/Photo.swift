//
//  Demo.swift
//  BoosterKit
//
//  Created by Travis Palmer on 10/21/16.
//  Copyright © 2016 Spartan. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import AlamofireObjectMapper

class Photo: Object, Mappable {

// Specify properties to ignore (Realm won't persist these)

//  override static func ignoredProperties() -> [String] {
//    return []
//  }

    @objc dynamic var albumId = 0
    @objc dynamic var photoId = 0
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    @objc dynamic var thumbnailUrl = ""

    override static func primaryKey() -> String? {
        return "photoId"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        albumId <- map["albumId"]
        photoId <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
}
