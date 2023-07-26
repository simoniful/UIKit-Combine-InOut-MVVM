//
//  MainVeiwModel.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import UIKit
import Combine

final class MainViewModel: ViewModel {
  private let serviceProvider = Service.sharedInstance
  var cancellables = Set<AnyCancellable>()
  
  var diffableDataSource: MoviesTableViewDiffableDataSource!
  var snapshot = NSDiffableDataSourceSnapshot<String?, Result>()
  
  enum Input {
    case viewDidLoad(Void)
    case searchKeyword(String)
  }
  
  enum Output {
    case completeDataFetch(Void)
    // case dataSource(MoviesTableViewDiffableDataSource)
  }
  
  private let outPut: PassthroughSubject<Output, Never> = .init()
  
  func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    input
      .receive(on: RunLoop.main)
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
      .sink { [weak self] event in
        switch event {
        case .viewDidLoad(_):
          self?.fetchMovies(keyword: "") {
            self?.outPut.send(.completeDataFetch(Void()))
          }
//          guard let diffableDataSource = self?.diffableDataSource else { return }
//          self?.outPut.send(
//            .dataSource(diffableDataSource)
//          )
        case .searchKeyword(let keyword):
          self?.fetchMovies(keyword: keyword){
            self?.outPut.send(.completeDataFetch(Void()))
          }
//          guard let diffableDataSource = self?.diffableDataSource else { return }
//          self?.outPut.send(
//            .dataSource(diffableDataSource)
//          )
        }
      }
      .store(in: &cancellables)
    
    return outPut.eraseToAnyPublisher()
  }
  
  private func fetchMovies(
    keyword: String,
    completionhandelr: @escaping () -> Void
  ) {
    serviceProvider.fetchFilms(for: keyword) { (results) in
      guard self.diffableDataSource != nil else { return }
      
      self.snapshot.deleteAllItems()
      self.snapshot.appendSections([""])
      
      if results.isEmpty {
        self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
        return
      }
      
      self.snapshot.appendItems(results, toSection: "")
      self.diffableDataSource.apply(self.snapshot, animatingDifferences: true)
    }
  }
}


