//
//  Restaurant.swift
//  SearchViewSwiftBook
//
//  Created by Victor Smirnov on 20.10.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import Foundation

struct Restaurant {
  
  var name: String
  var type: RestaurantType
}

enum RestaurantType: String {
  
  case restaurant = "Restaurant"
  case fastfood = "Fastfood"
  case bar = "Bar"
}
