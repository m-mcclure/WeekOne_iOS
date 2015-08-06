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
    //is completionHandler a function within a function?
    let accountStore = ACAccountStore()
    //ACAccountStore is an object that gives us an array
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      // granted is a bool, error is an NSError object... where did we get these variable names and where are they defined?
      if let error = error {
        //what is happening her, error = error? how has error been defined and where?
        completionHandler("please sign in", nil)
        
        
        return
      } else {
        if granted {
          //if granted is true... but where is its truthiness determined?
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            //what's the .first? first element in object/array? and why optional?
            completionHandler(nil, account)
            //what's happening here?
          } else {
            completionHandler("this app requires twitter access", nil)
          }
        }
      }
    } //
  }
  
  
  
  
  
}