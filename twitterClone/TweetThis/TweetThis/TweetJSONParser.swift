//
//  TweetJSONParser.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/3/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import Foundation

class TweetJSONParser {
  class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? {
    
    var error : NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject], data = rootObject["data"] as? [[String : AnyObject]] {
      var tweets = [Tweet]()
      
      for tweetObject in data {
        if let text = tweetObject["text"] as? String,
        //how to do this one... user : name dictionary...
          username = tweetObject["username"] as? String,
          id = tweetObject["id"] as? String,
          profileImageURL = tweetObject["profile_image_url_https"] as? String {
            println(text)
            let tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL)
            tweets.append(tweet)
            
        }
      }
      return tweets
    }
    
    if let error = error {
      //examine error in here
    }
    return nil
  }
  
}