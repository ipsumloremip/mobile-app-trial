//
//  SideDrawerController.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import SVProgressHUD

class SideDrawerController: UIViewController {

  @IBOutlet weak var signoutButton: UIButton!

  var viewModel: SideDrawerViewModel!

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    bind()
  }

  private func bind() {

    signoutButton.rx.tap
      .bind(to: viewModel.input.signoutTapped)
      .disposed(by: disposeBag)

    viewModel.output.signingOut
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { _ in
        SVProgressHUD.show()
      })
      .disposed(by: disposeBag)

    viewModel.output.didSucessfullySignout
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { _ in
        SVProgressHUD.dismiss()
      })
      .disposed(by: disposeBag)

  }

}
