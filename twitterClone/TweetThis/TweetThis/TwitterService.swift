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
  class func tweetsFromHomeTimeline(account: ACAccount, completionHandler: (String?, [Tweet]?) -> (Void)) {
    
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
    //SLRequest() template shows String! in forServiceType: ... why did you use a type rather than a string?
    //we passed nil to parameters: , but an example of when we might pass something other than nil?
    //any reason .GET is in all caps?
    //why did we need to ! the NSURL
    request.account = account
    // the account is the one we passed in as first param?
    request.performRequestWithHandler { (data, response, error) -> Void in
      //above, where do data, response, error come from?
      if let error = error {
        completionHandler("couldn't connect to server", nil)
      } else {
        println(response.statusCode)
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          //again where does "data" come from?
          completionHandler(nil, tweets)
        case 400...499:
          completionHandler("it's our fault", nil)
        case 500...599:
          completionHandler("it's the server's fault", nil)
        default:
          completionHandler("error occurred", nil)
        }
        //what would happen if the completionHandler() weren't there in any of the above lines?
        //below... you mentioned previously that a long line of diagonal } } } indicated there might be a cleaner way to code? at how many } do you usually draw the line?
      }
    }
  }
}