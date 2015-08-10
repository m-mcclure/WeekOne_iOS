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
  lazy var imageQueue = NSOperationQueue()
  
  func setNavBarStyle() {
    
    let bar:UINavigationBar! =  self.navigationController?.navigationBar
    
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    
    bar.tintColor = UIColor.whiteColor()
    bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    bar.shadowImage = UIImage()
    bar.backgroundColor = UIColor(red: 0.349, green: 0.678, blue: 0.922, alpha: 1.00)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    
    setNavBarStyle()
    
    
    
    tableView.estimatedRowHeight = 76
    tableView.rowHeight = UITableViewAutomaticDimension
    
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        //warning
      }
      if let account = account {
        TwitterService.sharedService.account = account

        TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets = tweets
              self.tableView.reloadData()
             
            })
          }
        })
      }
    }
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
  }
  
  override func viewWillAppear(animated: Bool) {
    setNavBarStyle()
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
    let userProfileImage = UIImage(data: data!)
    cell.userProfileImageButton.setBackgroundImage(userProfileImage, forState: .Normal)
   
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTweetDetails" {
      let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let selectedRow = indexPath!.row
      let selectedTweet = self.tweets[selectedRow]
      tweetDetailViewController.selectedTweet = selectedTweet
    } /*else if segue.identifier == "goToUserProfile" {
      let userProfileViewController = segue.destinationViewController as! UserProfileViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let selectedRow = indexPath!.row
      let selectedTweet = self.tweets[selectedRow]
      let tweetToPass = selectedTweet
      println(tweetToPass)
      userProfileViewController.passedTweet = tweetToPass
    }*/
  }
}

//MARK: UITableViewDelegate

extension ViewController : UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    //println("did select row")
    self.performSegueWithIdentifier("showTweetDetails", sender: self)
  }
}

