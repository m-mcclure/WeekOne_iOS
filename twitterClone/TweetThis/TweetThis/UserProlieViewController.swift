//
//  UserProlieViewController.swift
//  TweetThis
//
//  Created by Matthew McClure on 8/7/15.
//  Copyright (c) 2015 Matthew McClure. All rights reserved.
//

import UIKit

class UserProlieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let bar:UINavigationBar! =  self.navigationController?.navigationBar
      
      bar.tintColor = UIColor.whiteColor()
      bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
      bar.shadowImage = UIImage()
      bar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
