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
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
      
      var tweets = [Tweet]()
      for tweetObject in rootObject {
        
        if let text = tweetObject["text"] as? String,
        user = tweetObject["user"] as? [String : AnyObject],
          username = user["name"] as? String, profileImageURL = user["profile_image_url_https"] as? String, id = user["id_str"] as? String, backgroundImageURL = user["profile_banner_url"] as? String, screenname = user["screen_name"] as? String {
            let biggerProfileImageURL = profileImageURL.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger") as? String, retweeted = tweetObject["retweeted"] as? Bool
            
            let tweet = Tweet(text: text, username: username, screenname: screenname, id: id, userBackgroundImageURL: backgroundImageURL, profileImageURL: biggerProfileImageURL!, profileImage: nil/*, retweeted: retweeted!*/)
            tweets.append(tweet)
        }
      }
      return tweets
    }
    
    if let error = error {
      //examine error here
    }
    return nil
  }
  
}