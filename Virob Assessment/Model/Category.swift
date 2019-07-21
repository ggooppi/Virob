//
//  Category.swift
//  Virob Assessment
//
//  Created by gopinath.a on 20/07/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import ObjectMapper

class Popular: NSObject, Mappable {
    var currentLocation = ""
    var categories = [Category]()
    var dataCount = 0
    var data = [Data]()
    var nextPage = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        currentLocation <- map["current_location"]
        dataCount <- map["data_count"]
        categories <- map["categories"]
        nextPage <- map["next_page"]
        data <- map["data"]
    }
    
}

class Category: NSObject, Mappable {
    var categorySlug = ""
    var bcategoryName = ""
    var icon = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categorySlug <- map["category_slug"]
        bcategoryName <- map["bcategory_name"]
        icon <- map["icon"]
    }
}

class Data: NSObject, Mappable {
    var logo = ""
    var store_name = ""
    var offer = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        logo <- map["logo"]
        store_name <- map["store_name"]
        offer <- map["offer"]
    }
    
}
