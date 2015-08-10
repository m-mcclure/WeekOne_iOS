//
//  TweetDetailTableViewController.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/6/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController /*UIViewControllerDataSource*/ {
  
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
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return NO if you do not want the item to be re-orderable.
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