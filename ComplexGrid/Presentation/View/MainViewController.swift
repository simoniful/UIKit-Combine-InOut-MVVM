//
//  ViewController.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/22.
//

import UIKit
import Combine
import CombineCocoa
import CombineInterception

final class MainViewController: UIViewController {
  let mainView = MainView()
  let viewModel: MainViewModel
  
  var cancellables: Set<AnyCancellable> = []
  
  private lazy var input: PassthroughSubject<MainViewModel.Input, Never> = .init()
  private lazy var output = viewModel.transform(input: input.eraseToAnyPublisher())
  
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = mainView
    bind()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
  }
  
  private func bind() {
    // MARK: Table Bind
    viewModel.diffableDataSource = MoviesTableViewDiffableDataSource(
      tableView: self.mainView.tableView
    ) { (tableView, indexPath, model) -> UITableViewCell? in
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: MainTableViewCell.identifier,
          for: indexPath
        ) as? MainTableViewCell
        else { return UITableViewCell() }
        cell.movieObject = model
        return cell
    }

    // MARK: Input
    self.viewDidLoadPublisher
      .sink {
        self.input.send(.viewDidLoad($0))
      }
      .store(in: &cancellables)
    
    self.mainView.searchBar.textDidChangePublisher
      .sink {
        self.input.send(.searchKeyword($0))
      }
      .store(in: &cancellables)
    
    
    // MARK: Output
    output
      .receive(on: DispatchQueue.main)
      .sink { [weak self] event in
        switch event {
        case .completeDataFetch():
          print("Indicator 종료")
        }
      }
      .store(in: &cancellables)
  }
  
  private func setupNavigation() {
    self.view.backgroundColor = .systemBackground
    self.title = "영화 검색"
  }
}



