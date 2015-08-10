//
//  TwitterService.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/4/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  static let sharedService = TwitterService()
  
  var account : ACAccount?
  
  private init() {}
  
  class func tweetsFromHomeTimeline(account: ACAccount, completionHandler: (String?, [Tweet]?) -> (Void)) {
    
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
    request.account = self.sharedService.account
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        completionHandler("couldn't connect to server", nil)
      } else {
        println(response.statusCode)
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
        case 400...499:
          completionHandler("it's our fault", nil)
        case 500...599:
          completionHandler("it's the server's fault", nil)
        default:
          completionHandler("error occurred", nil)
        }
      }
    }
  }
  class func tweetsFromUserTimeline(userID: String, completionHandler: (String?, [Tweet]?) -> (Void)) {
    let userURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?" + "/\(userID)"
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: userURL)!, parameters: nil)
    request.account = self.sharedService.account
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        completionHandler("couldn't connect to server", nil)
      } else {
        println(response.statusCode)
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
        case 400...499:
          completionHandler("it's our fault", nil)
        case 500...599:
          completionHandler("it's the server's fault", nil)
        default:
          completionHandler("error occurred", nil)
        }
      }
    }
  }
}