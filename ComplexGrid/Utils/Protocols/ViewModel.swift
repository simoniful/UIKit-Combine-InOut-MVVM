//
//  ViewModel.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/26.
//

import Foundation
import Combine

protocol ViewModel {
  associatedtype Input
  associatedtype Output
  func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
  var cancellables: Set<AnyCancellable> { get set }
}
