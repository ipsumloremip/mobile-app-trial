//
//  DashboardClientCellViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import Moya

protocol DashboardClientCellViewModelInput {
  var optionsTapped: AnyObserver<Void> { get }
}

protocol DashboardClientCellViewModelOutput {
  var quote: Quote { get }
  var iconImageName: Observable<String> { get }
  var name: Observable<String> { get }
  var info: Observable<String> { get }
  var premiums: Observable<String> { get }
  var didTapOptions: Observable<Quote> { get }
}

protocol DashboardClientCellViewModelType: CellRepresentable {
  var input: DashboardClientCellViewModelInput { get }
  var output: DashboardClientCellViewModelOutput { get }
}

class DashboardClientCellViewModel: DashboardClientCellViewModelType, DashboardClientCellViewModelInput, DashboardClientCellViewModelOutput {

  var input: DashboardClientCellViewModelInput { return self }
  var output: DashboardClientCellViewModelOutput { return self }

  // MARK: Inputs
  var optionsTapped: AnyObserver<Void>

  // MARK: Outputs
  private(set) var quote: Quote
  var iconImageName: Observable<String>
  var name: Observable<String>
  var info: Observable<String>
  var premiums: Observable<String>
  var didTapOptions: Observable<Quote>

  init(quote: Quote) {
    
    self.quote = quote

    let _optionsTapped = PublishSubject<Void>()
    self.optionsTapped = _optionsTapped.asObserver()

    let primaryClient = quote.primaryClient

    self.iconImageName = Observable.just(primaryClient.isMale ? "icon-male" : "icon-female")
    self.name = Observable.just(primaryClient.name.capitalized)
    
    let info = "\(primaryClient.age), \(primaryClient.gender.uppercased()), \((primaryClient.isSmoker ? "Smoker" : "Non-Smoker")), Class \(primaryClient.occupationId), \(primaryClient.employedStatus.capitalized)"
    self.info = Observable.just(info)
    
    self.premiums = Observable.just("$\(primaryClient.premiums.minTotalPremium) - $\(primaryClient.premiums.maxTotalPremium)")

    self.didTapOptions = _optionsTapped.asObservable().map { quote }

  }

}

extension DashboardClientCellViewModel {
  
  static func registerCell(tableView: UITableView) {
    tableView.register(DashboardClientCell.self, forCellReuseIdentifier: DashboardClientCell.reuseId)
  }
  
  func cellInstance(for tableView: UITableView, in indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: DashboardClientCell.reuseId, for: indexPath) as! DashboardClientCell
  }
  
  func willDisplay(_ cell: UITableViewCell, in tableView: UITableView) {
    if let c = cell as? DashboardClientCell {
      c.viewModel = self
    }
  }
  
  func heightForCell(in tableView: UITableView) -> CGFloat {
    return 125
  }
  
}

