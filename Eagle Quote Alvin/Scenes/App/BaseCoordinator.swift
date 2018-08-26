//
//  BaseCoordinator.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 26/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import Foundation

class BaseCoordinator<ResultType> {
  
  typealias CoordinationResult = ResultType
  
  let disposeBag = DisposeBag()
  
  private let identifier = UUID()
  
  private var childCoordinators = [UUID: Any]()
  
  private func store<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = coordinator
  }
  
  private func free<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = nil
  }
  
  func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
    store(coordinator: coordinator)
    return coordinator.start()
      .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
  }
  
  func start() -> Observable<ResultType> {
    fatalError("Start method should be implemented.")
  }
}
