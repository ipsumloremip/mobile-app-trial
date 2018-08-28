//
//  DashboardQuoteSectionHeaderViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

protocol DashboardQuoteSectionHeaderViewModelInput {}

protocol DashboardQuoteSectionHeaderViewModelOutput {
  var dateString: Observable<String> { get }
}

protocol DashboardQuoteSectionHeaderViewModelType {
  var input: DashboardQuoteSectionHeaderViewModelInput { get }
  var output: DashboardQuoteSectionHeaderViewModelOutput { get }
}


class DashboardQuoteSectionHeaderViewModel: DashboardQuoteSectionHeaderViewModelType, DashboardQuoteSectionHeaderViewModelInput, DashboardQuoteSectionHeaderViewModelOutput {
  
  var input: DashboardQuoteSectionHeaderViewModelInput { return self }
  var output: DashboardQuoteSectionHeaderViewModelOutput { return self }
  
  var dateString: Observable<String>
  
  init(date: Date) {

    let df = DateFormatter()
    df.dateFormat = "EEEE, dd MMMM yyyy"
    
    self.dateString = Observable.just(df.string(from: date))
    
  }
  
}
