//
//  DashboardClientCell.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

class DashboardClientCell: UITableViewCell {
  
  @IBOutlet var innerContentView: UIView!
  
  @IBOutlet weak var iconImageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  
  @IBOutlet weak var optionsButton: UIButton!
  
  @IBOutlet weak var premiumsLabel: UILabel!
  
  var viewModel: DashboardClientCellViewModelType! {
    didSet {
      bind()
    }
  }
  
  private let disposeBag = DisposeBag()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    onInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    onInit()
  }
  
  func onInit() {
    Bundle.main.loadNibNamed("DashboardClientCell", owner: self, options: nil)
    contentView.addSubview(innerContentView)
    innerContentView.snp.makeConstraints { (make) in
      make.top.bottom.left.right.equalToSuperview()
    }
    
    separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    selectionStyle = .none
    optionsButton.tintColor = UIColor.EagleQuote.primary
  }
  
  private func bind() {
   
    optionsButton.rx.tap
      .bind(to: viewModel.input.optionsTapped)
      .disposed(by: disposeBag)
    
    viewModel.output.iconImageName
      .map { UIImage(named: $0) }
      .observeOn(MainScheduler.instance)
      .bind(to: iconImageView.rx.image)
      .disposed(by: disposeBag)
    
    viewModel.output.name
      .observeOn(MainScheduler.instance)
      .bind(to: nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.output.info
      .observeOn(MainScheduler.instance)
      .bind(to: infoLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.output.premiums
      .observeOn(MainScheduler.instance)
      .bind(to: premiumsLabel.rx.text)
      .disposed(by: disposeBag)
    
  }
  
}

