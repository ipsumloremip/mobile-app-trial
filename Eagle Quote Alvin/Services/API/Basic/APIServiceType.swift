//
//  APIServiceType.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 27/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift

protocol APIServiceType {
  
  func login(email: String, password: String) -> Observable<LoginResult>
  
  func logout(email: String, token: String) -> Observable<Void>

}
