//
//  ListTableViewController.swift
//  App5
//
//  Created by Kipras on 3/6/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, PresentedViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 43
        self.tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Declaring variables.
    var userListInput = [List]()
    var pathOfIndex: NSIndexPath!
    
    // Putting the data transfered by delegate into an array of List objects.
    func acceptData(data: AnyObject!) {
        print("ACCEPTING DATA")
        self.userListInput[pathOfIndex.row].listArray = data as! [String]
        print(userListInput[pathOfIndex.row].listArray)
    }
    
    // When cell which contains list's name is pressed, elements scene is displayed and delegate transfers an array of said list's elements to it.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let pvc = storyboard?.instantiateViewControllerWithIdentifier("ElementViewController") as! ElementViewController
        print("SENDING DATA")
        pvc.data = userListInput[indexPath.row].listArray
        pathOfIndex = indexPath
        print(userListInput[pathOfIndex.row].listArray)
        pvc.delegate = self
        self.presentViewController(pvc, animated: true, completion: nil)
    }

    // Sets number of sections in a cell.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Figures out the number of rows.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListInput.count
    }

    // Creates cell.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ListTableViewCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        let list = userListInput[indexPath.row]
        cell.listTextView.text = list.listName
        print(list.listName)
        cell.listImageView.image = list.listImage
        // Disables scrolling.
        cell.listTextView.scrollEnabled = false
        // Disables textView editing.
        cell.listTextView.editable = false
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Transfers data of new List object to lists scene when "save" button is pressed in CreateEdit scene.
    @IBAction func unwindToCreateEditViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? CreateEditViewController, list = sourceViewController.list {
            let newIndexPath = NSIndexPath(forRow: userListInput.count, inSection: 0)
            userListInput.append(list)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    

}
