//
//  MainView.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import UIKit
import SnapKit

final class MainView: UIView {
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    return searchBar
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    tableView.contentMode = .scaleToFill
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("MainView fatal error")
  }
  
  private func setupView() {
    [searchBar, tableView].forEach {
      addSubview($0)
    }
  }
  
  private func setupConstraints() {
    searchBar.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.leading.equalToSuperview().offset(16.0)
      $0.trailing.equalToSuperview().offset(-16.0)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.leading.equalToSuperview().offset(16.0)
      $0.trailing.equalToSuperview().offset(-16.0)
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
    }
  }
}
