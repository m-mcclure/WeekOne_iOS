//
//  LoginService.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/4/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
  class func loginForTwitter(completionHandler : (String?, ACAccount?) -> (Void)) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if let error = error {
        completionHandler("please sign in", nil)
        
        return
      } else {
        if granted {
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            completionHandler(nil, account)
          } else {
            completionHandler("this app requires twitter access", nil)
          }
        }
      }
    }
  }
}