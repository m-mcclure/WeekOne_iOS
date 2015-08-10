//
//  TweetDetailTableViewController.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/6/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  var selectedTweet : Tweet!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var retweetIconSquare: UIImageView!
  @IBOutlet weak var retweedByLabel: UILabel!
  @IBAction func tweetAuthorProfileImage(sender: UIButton) {
  }
  @IBOutlet weak var authorImage: UIButton!
  @IBOutlet weak var tweetAuthorUserNameLabel: UILabel!
  @IBOutlet weak var tweetAuthorHandleLabel: UILabel!
  @IBOutlet weak var tweetText: UILabel!
  @IBOutlet weak var timeStampLabel: UILabel!
  
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
    
    tweetAuthorUserNameLabel.text = selectedTweet.username
    tweetAuthorHandleLabel.text = "@\(selectedTweet.screenname)"
    tweetText.text = selectedTweet.text
    let url = NSURL(string: selectedTweet.profileImageURL)
    let data = NSData(contentsOfURL: url!)
    let userProfileImage = UIImage(data: data!)
    authorImage.setBackgroundImage(userProfileImage, forState: .Normal)
  }
  
  override func viewWillAppear(animated: Bool) {
    setNavBarStyle()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return NO if you do not want the specified item to be editable.
  return true
  }
  */
  
  
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    if segue.identifier == "goToUserProfile" {
      let userProfileViewController = segue.destinationViewController as! UserProfileViewController
      let tweetToPass = selectedTweet
      userProfileViewController.passedTweet = tweetToPass
    }
  }
}

//MARK: UITableViewDataSource
extension TweetDetailViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //just returning a few blank Xibs until I can get user timeline tweets to load
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "asdf"
    
    
    return cell
  }
  
}