//
//  TimelineTableViewController.swift
//  GunnHacks
//
//  Created by Sonal Muthal on 10/28/17.
//  Copyright © 2017 Jacob Kim. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineTableViewController: TWTRTimelineViewController {
        
    var tweetNumber = 0
    static var tweetString = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let client = TWTRAPIClient()
        
        
        for _ in 1...20       {
            let randNum = arc4random_uniform(300)
            
            showTweet(client: client, randNum: randNum)
            
        }
        
        self.dataSource = TWTRListTimelineDataSource(listSlug: "surfing", listOwnerScreenName: "stevenhepting", apiClient: client)
        
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
//        
//        let client = TWTRAPIClient()
//        
//        
//        
//        return cell
//    }
    
    func showTweet(client: TWTRAPIClient, randNum: UInt32){
        
        client.loadTweet(withID: "\(randNum)") { (tweet, error) in
            if let t = tweet {
                print(t)
                TimelineTableViewController.tweetString += "\(t.text)"
                let tweetView = TWTRTweetView(tweet: t)
                tweetView.showActionButtons = true
                self.scrollView.addSubview(tweetView)
                
                self.tweetNumber += 1

                
//                let horizontalContraints = NSLayoutConstraint(item: tweetView, attribute:
//                    .leadingMargin, relatedBy: .equal, toItem: self.view,
//                                    attribute: .leadingMargin, multiplier: 1.0,
//                                    constant: 20)
//                
//                //pin the slider 20 points from the right edge of the super view
//                //negative because we want to pin -20 points from the end of the superview.
//                //ex. if with of super view is 300, 300-20 = 280 position
//                let horizontal2Contraints = NSLayoutConstraint(item: tweetView, attribute:
//                    .trailingMargin, relatedBy: .equal, toItem: self.view,
//                                     attribute: .trailingMargin, multiplier: 1.0, constant: -20)
                
                let xConstraint = NSLayoutConstraint(item: tweetView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)

                
                //pin 100 points from the top of the super
                let pinTop = NSLayoutConstraint(item: tweetView, attribute: .top, relatedBy: .equal,
                                                toItem: self.view, attribute: .top, multiplier: 1.0, constant: CGFloat(100*self.tweetNumber))
                
                tweetView.translatesAutoresizingMaskIntoConstraints = false
                
                //IOS 8
                //activate the constrains.
                //we pass an array of all the contraints
                NSLayoutConstraint.activate([xConstraint,pinTop])
                
                
            } else {
                print("Failed to load Tweet:")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
