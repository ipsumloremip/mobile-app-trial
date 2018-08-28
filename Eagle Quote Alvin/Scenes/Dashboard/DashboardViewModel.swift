//
//  DashboardViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import Moya

protocol DashboardViewModelInput {
  func refresh()
  var loadMore: AnyObserver<Bool> { get }
}

protocol DashboardViewModelOutput {
  var isRefreshing: Observable<Bool> { get }
  var sectionViewModels: Observable<[DashboardQuoteSectionViewModelType]>! { get }
}

protocol DashboardViewModelType {
  var input: DashboardViewModelInput { get }
  var output: DashboardViewModelOutput { get }
}

class DashboardViewModel: DashboardViewModelType, DashboardViewModelInput, DashboardViewModelOutput {

  var input: DashboardViewModelInput { return self }
  var output: DashboardViewModelOutput { return self }

  // MARK: Inputs
  var loadMore: AnyObserver<Bool>

  // MARK: Outputs
  var isRefreshing: Observable<Bool>
  var sectionViewModels: Observable<[DashboardQuoteSectionViewModelType]>!

  private let refreshProperty: AnyObserver<Bool>

  private var page = 1
  private let perPage = 20

  init(service: AuthorizedAPIServiceType = AuthorizedAPIService()) {

    var quotesArray = [Quote]([])

    let _loadMore = BehaviorSubject<Bool>(value: false)
    self.loadMore = _loadMore.asObserver()

    let _refreshProperty = PublishSubject<Bool>()
    self.refreshProperty = _refreshProperty.asObserver()
    self.isRefreshing = _refreshProperty.asObservable()

    let requestFirst = isRefreshing
      .flatMap { [weak self] isRefreshing -> Observable<[Quote]> in
        guard let s = self,
          isRefreshing else { return .empty() }
        return service.fetchQuotes(page: 1, perPage: s.perPage)
          .catchError { [weak self] error in
            self?.refreshProperty.onNext(false)
            return Observable.empty()
          }
          .map { $0.quotes }

      }
      .do (onNext: { [weak self] _ in
        quotesArray = []
        self?.page = 1
      })

    let requestNext = _loadMore
      .asObservable()
      .flatMap { [weak self] loadMore -> Observable<[Quote]> in
        guard let s = self,
          loadMore else { return .empty() }
        return service.fetchQuotes(page: s.page, perPage: s.perPage)
          .catchError { [weak self] error in
            self?.refreshProperty.onNext(false)
            return Observable.empty()
          }
          .map { $0.quotes }

    }


    self.sectionViewModels = Observable.merge(requestFirst, requestNext)
      .map { [weak self] quotes -> [Quote] in
        quotes.forEach { quote in
          quotesArray.append(quote)
        }
        self?.refreshProperty.onNext(false)
        return quotesArray
      }
      .map { quotes -> [DashboardQuoteSectionViewModelType] in
        let groupDict = Dictionary(grouping: quotes, by: { q in return q.createdAtDateOnly ?? "" })
        return Array(groupDict.keys.map { groupDict[$0] })
          .map { groupedQuotes in
            return groupedQuotes
              .map { quotes in
                return quotes.map { DashboardClientCellViewModel(quote: $0) }
              }
              .map { cellVMs in
                return DashboardQuoteSectionViewModel(cellViewModels: cellVMs)
              }!
        }
    }


  }

  func refresh() {
    refreshProperty.onNext(true)
  }

}

