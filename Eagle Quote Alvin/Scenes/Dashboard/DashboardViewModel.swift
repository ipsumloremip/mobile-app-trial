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
  var drawerButtonTapped: AnyObserver<Void> { get }
}

protocol DashboardViewModelOutput {
  var isRefreshing: Observable<Bool> { get }
  var sectionViewModels: Observable<[DashboardQuoteSectionViewModelType]>! { get }
  var didTapQuoteCellOptions: Observable<Quote>! { get }
  var didTapDrawerButton: Observable<Void> { get }
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
  var drawerButtonTapped: AnyObserver<Void>

  // MARK: Outputs
  var isRefreshing: Observable<Bool>
  var sectionViewModels: Observable<[DashboardQuoteSectionViewModelType]>!
  var didTapQuoteCellOptions: Observable<Quote>!
  var didTapDrawerButton: Observable<Void>

  private let refreshProperty: AnyObserver<Bool>

  private var page = 1
  private let perPage = 20

  private let disposeBag = DisposeBag()

  init(service: AuthorizedAPIServiceType = AuthorizedAPIService()) {

    var quotesArray = [Quote]([])

    let _loadMore = BehaviorSubject<Bool>(value: false)
    self.loadMore = _loadMore.asObserver()
    
    let _drawerButtonTapped = PublishSubject<Void>()
    self.drawerButtonTapped = _drawerButtonTapped.asObserver()
    self.didTapDrawerButton = _drawerButtonTapped.asObservable()

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
            return .empty()
          }
          .map { $0.quotes }

      }
      .filterEmpty()
      .do (onNext: { [weak self] _ in
        quotesArray = []
        self?.page = 2
      })

    let requestNext = _loadMore
      .asObservable()
      .flatMap { [weak self] loadMore -> Observable<[Quote]> in
        guard let s = self,
          loadMore else { return .empty() }
        return service.fetchQuotes(page: s.page, perPage: s.perPage)
          .catchError { [weak self] error in
            self?.refreshProperty.onNext(false)
            return .empty()
          }
          .map { $0.quotes }
      }
      .filterEmpty()
      .do (onNext: { [weak self] _ in
        self?.page += 1
      })


    let _didTapQuoteCellOptions = PublishSubject<Quote>()
    self.didTapQuoteCellOptions = _didTapQuoteCellOptions.asObservable()

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
        
        let sortedKeys = groupDict.keys.sorted(by: { d1, d2 in
          let df = DateFormatter()
          df.dateStyle = .short
          return df.date(from: d1)! > df.date(from: d2)!
        })
        
        return Array(sortedKeys.map { groupDict[$0] })
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
      .do(onNext: { [weak self] svms in
        guard let s = self else { return }
        s.refreshProperty.onNext(false)
        svms.forEach {
          $0.output.didTapQuoteCellOptions
            .subscribe(onNext: { quote in
              _didTapQuoteCellOptions.onNext(quote)
            })
            .disposed(by: s.disposeBag)
        }
      })


  }

  func refresh() {
    refreshProperty.onNext(true)
  }

}

