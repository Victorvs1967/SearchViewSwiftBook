//
//  DetailViewController.swift
//  SearchViewSwiftBook
//
//  Created by Victor Smirnov on 20.10.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var restaurant: Restaurant!
  
  @IBOutlet weak var restaurantImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = restaurant.name
    restaurantImage.image = UIImage(named: restaurant.name)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
