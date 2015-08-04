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
    tableView.dataSource = self
    tableView.reloadData()
    
    if let filepath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      if let data = NSData(contentsOfFile: filepath) {
        if let tweets = TweetJSONParser.tweetsFromJSONData(data) {
          self.tweets = tweets
        }
        
      }
    }

    // Do any additional setup after loading the view, typically from a nib.
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
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! UITableViewCell
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.text
    
    return cell
  }
}

