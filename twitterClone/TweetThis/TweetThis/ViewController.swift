//
//  ViewController.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/3/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    println("ok")
    tableView.estimatedRowHeight = 76
    tableView.rowHeight = UITableViewAutomaticDimension
    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        //warning
      }
      if let account = account {
        TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets = tweets
              self.tableView.reloadData()
              //what is happening in lines 24-29?
            }) //i have extra paren here... you don't... does it matter?
          }
        })
      }
    }
    tableView.dataSource = self
    tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

//MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
    let tweet = tweets[indexPath.row]
    //cell.textLabel?.text = tweet.text
    cell.usernameLabel.text = tweet.username
    cell.tweetTextLabel.text = tweet.text
    cell.handleLabel.text = "@\(tweet.screenname)"
    let url = NSURL(string: tweet.profileImageURL)
    let data = NSData(contentsOfURL: url!)
    cell.profileImage.image = UIImage(data: data!)
    //cell.profileImage.image = UIImage(named: tweet.profileImageURL)
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTweetDetails" {
      let tweetDetailTableViewController = segue.destinationViewController as! TweetDetailTableViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let selectedRow = indexPath!.row
      let selectedTweet = self.tweets[selectedRow]
      tweetDetailTableViewController.selectedTweet = selectedTweet
    }
  }
}

