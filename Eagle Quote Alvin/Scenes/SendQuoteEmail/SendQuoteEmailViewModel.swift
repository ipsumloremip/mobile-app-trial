//
//  SendQuoteEmailViewModel.swift
//  Eagle Quote Alvin
//
//  Created by Alvin Jay C. Cosare on 28/08/2018.
//  Copyright © 2018 BlackFin. All rights reserved.
//

import Foundation

import RxSwift
import Moya

typealias SendQuoteEmailErrorInfo = (title: String, message: String)

protocol SendQuoteEmailViewModelInput {
  var sendEmailTapped: AnyObserver<Void> { get }
  var toEmails: AnyObserver<[String]> { get }
  var ccEmails: AnyObserver<[String]> { get }
  var subject: AnyObserver<String?> { get }
  var body: AnyObserver<String?> { get }
}

protocol SendQuoteEmailViewModelOutput {
  var defaultSubject: Observable<String> { get }
  var defaultBody: Observable<String> { get }
  var defaultCcEmails: Observable<[String]> { get }
  
  var didSuccessfullySendEmail: Observable<Void> { get }
  var didReceiveSendQuoteEmailError: Observable<SendQuoteEmailErrorInfo> { get }
  var didInvalidateForm: Observable<SendQuoteEmailErrorInfo> { get }
  var sendingEmail: Observable<Void> { get }
}

protocol SendQuoteEmailViewModelType {
  var input: SendQuoteEmailViewModelInput { get }
  var output: SendQuoteEmailViewModelOutput { get }
}

class SendQuoteEmailViewModel: SendQuoteEmailViewModelType, SendQuoteEmailViewModelInput, SendQuoteEmailViewModelOutput {

  var input: SendQuoteEmailViewModelInput { return self }
  var output: SendQuoteEmailViewModelOutput { return self }

  // MARK: Input
  var sendEmailTapped: AnyObserver<Void>
  var toEmails: AnyObserver<[String]>
  var ccEmails: AnyObserver<[String]>
  var subject: AnyObserver<String?>
  var body: AnyObserver<String?>

  // MARK: Output
  var defaultSubject: Observable<String>
  var defaultBody: Observable<String>
  var defaultCcEmails: Observable<[String]>
  
  var didSuccessfullySendEmail: Observable<Void>
  var didReceiveSendQuoteEmailError: Observable<SendQuoteEmailErrorInfo>
  var didInvalidateForm: Observable<SendQuoteEmailErrorInfo>
  var sendingEmail: Observable<Void>

  init(user: User, quote: Quote, service: AuthorizedAPIServiceType = AuthorizedAPIService()) {

    typealias FormInput = (toEmails: [String], ccEmails: [String], subject: String?, body: String?)

    let _sendEmailTapped = PublishSubject<Void>()
    self.sendEmailTapped = _sendEmailTapped.asObserver()

    let _toEmails = BehaviorSubject<[String]>(value: [])
    self.toEmails = _toEmails.asObserver()

    let _ccEmails = BehaviorSubject<[String]>(value: [])
    self.ccEmails = _ccEmails.asObserver()

    let _subject = BehaviorSubject<String?>(value: nil)
    self.subject = _subject.asObserver()

    let _body = BehaviorSubject<String?>(value: nil)
    self.body = _body.asObserver()


    let _didReceiveSendQuoteEmailError = PublishSubject<SendQuoteEmailErrorInfo>()
    self.didReceiveSendQuoteEmailError = _didReceiveSendQuoteEmailError.asObservable()

    let _didInvalidateForm = PublishSubject<SendQuoteEmailErrorInfo>()
    self.didInvalidateForm = _didInvalidateForm.asObservable()

    let _sendingEmail = PublishSubject<Void>()
    self.sendingEmail = _sendingEmail.asObservable()

    let formInput = Observable.combineLatest(
      _toEmails.asObservable(),
      _ccEmails.asObservable(),
      _subject.asObservable(),
      _body.asObservable()
    ) {
      FormInput(
        toEmails: $0,
        ccEmails: $1,
        subject: $2,
        body: $3
      )
    }

    let validForm = _sendEmailTapped
      .asObservable()
      .withLatestFrom(formInput) { _, credentials in return credentials }
      .filter { formInput in

        guard formInput.toEmails.isNotEmpty else {
          let e = LoginErrorInfo(title: "\"To\" recipient required", message: "Please enter at least one email under \"To\".")
          _didInvalidateForm.onNext(e)
          return false
        }

        guard let subject = formInput.subject, !subject.isEmpty else {
          let e = LoginErrorInfo(title: "Subject required", message: "Please a subject for the email")
          _didInvalidateForm.onNext(e)
          return false
        }

        guard let body = formInput.body, !body.isEmpty else {
          let e = LoginErrorInfo(title: "Body required", message: "Please compose a message for the email")
          _didInvalidateForm.onNext(e)
          return false
        }

        _sendingEmail.onNext(Void())
        return true
    }


    self.defaultSubject = Observable.just("Insurance Quote for \(quote.primaryClient.name)")
    self.defaultBody = Observable.just("Your insurance quote is attached\n\nKind regards\n\(user.fullName)")
    self.defaultCcEmails = Observable.just([user.email])


    self.didSuccessfullySendEmail = Observable
      .zip(validForm, sendingEmail.delay(0.5, scheduler: MainScheduler.instance)) { validForm, _ in return validForm }
      .map { validForm -> QuoteEmail in

        let toRecipients = validForm.toEmails.map { QuoteEmail.Recipient(email: $0, name: nil, type: .to) }
        let ccRecipients = validForm.ccEmails.map { QuoteEmail.Recipient(email: $0, name: nil, type: .cc) }
        let recipients = toRecipients + ccRecipients

        return QuoteEmail(recipients: recipients, replyTo: nil, subject: validForm.subject!, body: validForm.body!, quoteId: quote.quoteId)
      }
      .flatMap { emailPayload in


        return service.sendEmail(emailPayload: emailPayload)
          .catchError { error in

            let moyaError = error as? Moya.MoyaError
            let message = moyaError?.endpointResponse?.message ?? "Something went wrong. Please try again."

            let e = LoginErrorInfo(title: "Failed to send email", message: message)
            _didReceiveSendQuoteEmailError.onNext(e)
            return Observable.empty()
        }
    }

  }

}

