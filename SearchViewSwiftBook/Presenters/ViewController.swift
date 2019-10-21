//
//  ViewController.swift
//  SearchViewSwiftBook
//
//  Created by Victor Smirnov on 20.10.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private let restaurants = [
    Restaurant(name: "Mafia", type: .fastfood),
    Restaurant(name: "Birzha", type: .restaurant),
    Restaurant(name: "CityTown", type: .restaurant),
    Restaurant(name: "KentBar", type: .bar),
    Restaurant(name: "Vilagio", type: .restaurant),
    Restaurant(name: "Burger Farm", type: .fastfood),
    Restaurant(name: "Kartofan", type: .fastfood),
    Restaurant(name: "TownCafe", type: .restaurant),
]
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchFooter: SearchFooter!
  
  private var searchController: UISearchController!
  private var filteredRestaurants = [Restaurant]()
  private var searchBarIsEmpty: Bool {
    guard let text = searchController.searchBar.text else { return false }
    return text.isEmpty
  }
  private var isFiltering: Bool {
    let searchScoreIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!searchBarIsEmpty || searchScoreIsFiltering)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    setupSearchController()
  }
  
  //  MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationVC = segue.destination as? DetailViewController {
      if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.restaurant = isFiltering ? filteredRestaurants[indexPath.row] : restaurants[indexPath.row]
      }
    }
  }
  
}

// MARK: - TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  private func setupTableView() {
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    isFiltering ? searchFooter.setSearchFooter(filteredRestaurants.count, of: restaurants.count) : searchFooter.hideSearchFooter()
    return isFiltering ? filteredRestaurants.count : restaurants.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let restaurant = isFiltering ? filteredRestaurants[indexPath.row] : restaurants[indexPath.row]
    
    cell.textLabel?.text = restaurant.name
    cell.detailTextLabel?.text = restaurant.type.rawValue
    
    return cell
  }
  
}

// MARK: - SearchController
extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
  
  private func setupSearchController() {
    
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "Enter restaurant..."
    searchController.searchBar.scopeButtonTitles = ["All", "Restaurant", "Fastfood", "Bar"]
    searchController.searchBar.delegate = self
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    
    navigationItem.searchController = searchController
    navigationController?.navigationBar.prefersLargeTitles = true
    definesPresentationContext = true
    
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    guard let searchText = searchController.searchBar.text else { return }
    filterContent(searchText, scope: scope)
    tableView.reloadData()
  }
  
  private func filterContent(_ searchText: String, scope: String = "All") {
    
    filteredRestaurants = restaurants.filter({ (restaurant) -> Bool in
      
      let doesCategoryMatch = (scope == "All") || (restaurant.type.rawValue == scope)
      
      if searchBarIsEmpty {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && restaurant.name.localizedCaseInsensitiveContains(searchText)
      }      
    })
  }
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    
    filterContent(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

