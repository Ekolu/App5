//
//  ElementViewController.swift
//  App5
//
//  Created by Kipras on 3/6/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputButton.enabled = false
        self.tableView.estimatedRowHeight = 43
        self.tableView.rowHeight = UITableViewAutomaticDimension
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardShown:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardHidden:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var textFieldConstraint: NSLayoutConstraint!
    
    // Declaring variables.
    var userInput = [String]()
    var pathOfIndex: NSIndexPath!
    
    // On button click puts user input into an array and saves it to memory.
    @IBAction func AddInput(sender: AnyObject) {
        userInput.append(textFieldInput.text!)
        textFieldInput.text="";
        inputButton.enabled = false
        self.tableView.reloadData()
        self.view.endEditing(true)
        print(userInput)
    }
    
    // Validates user input.
    @IBAction func Validation(sender: UITextField) {
        if (textFieldInput.text!.isEmpty)
        {
            inputButton.enabled = false
        }
        else
        {
            inputButton.enabled = true
        }
    }
    
    // Figures out the number of rows.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInput.count
    }
    
    // Raises the height of the textfield when keyboard appears.
    func keyboardShown(notification:NSNotification) {
        adjustingHeight(true, notification: notification)
    }
    
    // Lowers the height of the textfield when keyboard is hidden.
    func keyboardHidden(notification:NSNotification) {
        adjustingHeight(false, notification: notification)
    }
    
    // Adjusts the height of textfield when keyboard is on/off.
    func adjustingHeight(show:Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let changeInHeight = (CGRectGetHeight(keyboardFrame) + 8) * (show ? 1 : -1)
        UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
            self.textFieldConstraint.constant += changeInHeight
        })
    }
    
    // Closes keyboard when an empty area on screen is touched.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Corrects for keyboard bug, when keyboard and textfield fail to adjust when rotated.
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator){
        if UIDevice.currentDevice().orientation.isLandscape.boolValue && textFieldInput.isFirstResponder(){
            self.textFieldInput.resignFirstResponder()
            self.tableView.reloadData()
        }
        else if UIDevice.currentDevice().orientation.isPortrait.boolValue && textFieldInput.isFirstResponder(){
            self.textFieldInput.resignFirstResponder()
            self.tableView.reloadData()
        }
    }
    
    // Creates cells.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ElementTableViewCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ElementTableViewCell
        cell.elementTextView.text = userInput[indexPath.row]
        // Disables scrolling, so that textview would expand if there is a lot of input instead of allowing scrolling.
        cell.elementTextView.scrollEnabled = false
        // Disables textView editing.
        cell.elementTextView.editable = false
        return cell
    }
    
    // Deletes the specified row and an element from an array.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            userInput.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if backButton === sender {
            let counter = segue.destinationViewController as! ListTableViewController
            counter.userListInput[pathOfIndex.row].listArray = userInput
            print(userInput)
            print("1")
        }
    }
    
    
}