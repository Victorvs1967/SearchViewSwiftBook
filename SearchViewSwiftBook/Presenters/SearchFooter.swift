//
//  SearchFooter.swift
//  SearchViewSwiftBook
//
//  Created by Victor Smirnov on 20.10.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class SearchFooter: UIView {
  
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    configureView()
  }
  
  override func draw(_ rect: CGRect) {
    
    label.frame = bounds
  }
  
  private func configureView() {
    
    backgroundColor = .gray
    alpha = 0
    
    label.textAlignment = .center
    label.textColor = .white
    addSubview(label)
  }
  
  private func showFooter() {
    alpha = 1
  }
  
  private func hideFooter() {
    alpha = 0
  }
  
}

// MARK: Public API
extension SearchFooter {
  
  func setNotFiltering() {
    label.text = ""
    hideFooter()
  }
  
  func setIsFilteringToShow(_ fileredItemsCount: Int, of totalItemCount: Int) {
    
    switch fileredItemsCount {
    case totalItemCount: setNotFiltering()
    case 0:
      label.text = "No items match your query"
      showFooter()
    default:
      label.text = "Find \(fileredItemsCount) of \(totalItemCount)"
      showFooter()
    }
  }
}
