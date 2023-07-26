//
//  UIViewController+.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import UIKit
import Combine
import CombineInterception

extension UIViewController {
  var viewDidLoadPublisher: AnyPublisher<Void, Never> {
    let selector = #selector(UIViewController.viewDidLoad)
    return publisher(for: selector)
      .map { _ in () }
      .eraseToAnyPublisher()
  }
  
  var viewWillAppearPublisher: AnyPublisher<Bool, Never> {
    let selector = #selector(UIViewController.viewWillAppear(_:))
    return intercept(selector)
      .map { $0[0] as? Bool ?? false }
      .eraseToAnyPublisher()
  }
}
