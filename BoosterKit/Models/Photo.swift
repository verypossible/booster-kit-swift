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

    dynamic var albumId = 0
    dynamic var photoId = 0
    dynamic var title = ""
    dynamic var url = ""
    dynamic var thumbnailUrl = ""

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
