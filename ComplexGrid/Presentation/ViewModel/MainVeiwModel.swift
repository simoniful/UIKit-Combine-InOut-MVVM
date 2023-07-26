//
//  MainVeiwModel.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import Foundation
import Combine

final class MainViewModel: ViewModel {
  private let serviceProvider = Service.sharedInstance
  var cancellables = Set<AnyCancellable>()
  
  enum Input {
    case viewDidLoad(Void)
    case searchKeyword(String)
  }
  
  enum Output {
    case movieListData([Result])
  }
  
  private let outPut: PassthroughSubject<Output, Never> = .init()
  
  func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    input
      .receive(on: RunLoop.main)
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
      .sink { [weak self] event in
        switch event {
        case .viewDidLoad(_):
          self?.fetchMovies(keyword: "") { [weak self] results in
            self?.outPut.send(.movieListData(results))
          }

        case .searchKeyword(let keyword):
          self?.fetchMovies(keyword: keyword){ [weak self] results in
            self?.outPut.send(.movieListData(results))
          }

        }
      }
      .store(in: &cancellables)
    
    return outPut.eraseToAnyPublisher()
  }
  
  private func fetchMovies(
    keyword: String,
    completionhandelr: @escaping ([Result]) -> Void
  ) {
    serviceProvider.fetchFilms(for: keyword) { (results) in
      completionhandelr(results)
    }
  }
}


