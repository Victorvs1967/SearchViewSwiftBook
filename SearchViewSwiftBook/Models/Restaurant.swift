//
//  Restaurant.swift
//  SearchViewSwiftBook
//
//  Created by Victor Smirnov on 20.10.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import RealmSwift

class Restaurant: Object {
  
 @objc dynamic var name = ""
  @objc dynamic var type: RestaurantType?
}

class RestaurantType: Object {
  @objc dynamic var name = ""
}
