//
//  UserProlieViewController.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/7/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
  
  var passedTweet : Tweet!
  var userTweets = [Tweet]()
  lazy var imageQueue = NSOperationQueue()
  
  @IBOutlet weak var tableView: UITableView!

  @IBOutlet weak var userProfileImage: UIImageView!
  @IBOutlet weak var userBackgroundImage: UIImageView!
  @IBOutlet weak var userFullName: UILabel!
  @IBOutlet weak var userHandle: UILabel!
  @IBOutlet weak var userByline: UILabel!
  @IBOutlet weak var userLocation: UILabel!
  @IBOutlet weak var userURL: UILabel!
  @IBOutlet weak var userFollowing: UILabel!
  @IBOutlet weak var userFollowers: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let bar:UINavigationBar! =  self.navigationController?.navigationBar
      bar.tintColor = UIColor.whiteColor()
      bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
      bar.shadowImage = UIImage()
      bar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)


      userFullName.text = passedTweet.username
      userHandle.text = "@\(passedTweet.screenname)"
      
      let url = NSURL(string: passedTweet.profileImageURL)
      let data = NSData(contentsOfURL: url!)
      userProfileImage.image = UIImage(data: data!)
      if let url = NSURL(string: passedTweet.userBackgroundImageURL) {
      let data = NSData(contentsOfURL: url)
      userBackgroundImage.image = UIImage(data: data!)
      }
      
      tableView.estimatedRowHeight = 76
      tableView.rowHeight = UITableViewAutomaticDimension
      
      tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
      let screenName = passedTweet.screenname
      
      TwitterService.tweetsFromUserTimeline(screenName, completionHandler: { (errorDescription, tweets) -> (Void) in
        if let tweets = tweets {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.userTweets = tweets
            self.tableView.reloadData()
            println("tweetsFromUserTimeline() triggered")
            println(self.userTweets.count)
          })
        }
      })

      tableView.dataSource = self
      tableView.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: UITableViewDataSource
extension UserProfileViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //just returning a few blank Xibs until I can get user timeline tweets to load
    return userTweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
    cell.tag++
    let tag = cell.tag
    var tweet = userTweets[indexPath.row]
    cell.usernameLabel.text = tweet.username
    cell.tweetTextLabel.text = tweet.text
    cell.handleLabel.text = "@\(tweet.screenname)"
    let url = NSURL(string: tweet.profileImageURL)
    let data = NSData(contentsOfURL: url!)
    let userProfileImage = UIImage(data: data!)
    cell.userProfileImageButton.setBackgroundImage(userProfileImage, forState: .Normal)
    if let profileImage = tweet.profileImage {
      cell.userProfileImageButton.setBackgroundImage(profileImage, forState: .Normal)
    } else {
      
      imageQueue.addOperationWithBlock({ () -> Void in
        if let imageURL = NSURL(string: tweet.profileImageURL),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            var size : CGSize
            switch UIScreen.mainScreen().scale {
            case 2:
              size = CGSize(width: 160, height: 160)
            case 3:
              size = CGSize(width: 240, height: 240)
            default:
              size = CGSize(width: 80, height: 80)
            }
            
            let resizedImage = ImageResizer.resizeImage(image, size: size)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              tweet.profileImage = resizedImage
              self.userTweets[indexPath.row] = tweet
              if cell.tag == tag {
                cell.userProfileImageButton.setBackgroundImage(resizedImage, forState: .Normal)
              }
            })
        }
      })
    }
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTweetDetails" {
      let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let selectedRow = indexPath!.row
      let selectedTweet = self.userTweets[selectedRow]
      tweetDetailViewController.selectedTweet = selectedTweet
    }
  }
}

//MARK: UITableViewDelegate

extension UserProfileViewController : UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    //println("did select row")
    self.performSegueWithIdentifier("showTweetDetails", sender: self)
  }
}

