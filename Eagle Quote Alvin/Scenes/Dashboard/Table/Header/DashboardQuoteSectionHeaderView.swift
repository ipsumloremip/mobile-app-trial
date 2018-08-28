//
//  DashboardQuoteSectionHeaderView.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

class DashboardQuoteSectionHeaderView: UITableViewHeaderFooterView {
  
  @IBOutlet var innerContentView: UIView!
  
  @IBOutlet weak var dateLabel: UILabel!
  
  private let disposeBag = DisposeBag()
  
  var viewModel: DashboardQuoteSectionHeaderViewModelType! {
    didSet {
      self.bind()
    }
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    onInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    onInit()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    onInit()
  }
  
  func onInit() {
    Bundle.main.loadNibNamed("DashboardQuoteSectionHeaderView", owner: self, options: nil)
    contentView.addSubview(innerContentView)
    innerContentView.snp.makeConstraints { (make) in
      make.top.bottom.left.right.equalToSuperview()
    }
  }
  
  private func bind() {
    
    viewModel.output.dateString
      .observeOn(MainScheduler.instance)
      .bind(to: dateLabel.rx.text)
      .disposed(by: disposeBag)
    
  }
  
}
