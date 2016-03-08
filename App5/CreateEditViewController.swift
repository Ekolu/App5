//
//  CreateEditViewController.swift
//  App5
//
//  Created by Kipras on 3/5/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class CreateEditViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureButton()
        if let list = list {
            navigationItem.title = list.listName
            listTextField.text   = list.listName
            addedImage = list.listImage
        }
        
        // Configures photo button display to account for edit behaviour.
        if addedImage != nil {
            addPhotoButton.setBackgroundImage(addedImage, forState: UIControlState.Normal)
            addPhotoButton.setTitle("", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var listTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Initializes variables.
    var list: List?
    var addedImage: UIImage?
    
    // Adds borders to textView, so it would look prettier.
    func configureList() {
        let borderBottom = CALayer()
        let borderWidth = CGFloat(2.0)
        borderBottom.borderColor = UIColor.grayColor().CGColor
        borderBottom.frame = CGRect(x: 0, y: listTextField.frame.height - 1.0, width: listTextField.frame.width , height: listTextField.frame.height - 1.0)
        borderBottom.borderWidth = borderWidth
        listTextField.layer.addSublayer(borderBottom)
        listTextField.layer.masksToBounds = true
        let borderTop = CALayer()
        borderTop.borderColor = UIColor.grayColor().CGColor
        borderTop.frame = CGRect(x: 0, y: 0, width: listTextField.frame.width, height: 1)
        borderTop.borderWidth = borderWidth
        listTextField.layer.addSublayer(borderTop)
        listTextField.layer.masksToBounds = true
    }
    
    // Configures addPhoto button so it would be round.
    func configureButton() {
        photoButton.layer.cornerRadius = photoButton.bounds.size.width / 2.0
        photoButton.layer.masksToBounds = true
        photoButton.layer.borderColor = UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:1).CGColor as CGColorRef
        photoButton.layer.borderWidth = 2.0
        photoButton.clipsToBounds = true
        photoButton.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    
    // Updates the visuals of screen.
    override func viewDidLayoutSubviews() {
        configureButton()
        configureList()
    }
    
    // Hides keyboard after return key is pressed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Closes keyboard when an empty area on screen is touched.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Allows user to add an image from its devices library.
    @IBAction func AddPhotoAction(sender: UIButton) {
        self.view.endEditing(true)
        let pickImage = UIImagePickerController()
        pickImage.sourceType = .PhotoLibrary
        pickImage.delegate = self
        presentViewController(pickImage, animated: true, completion: nil)
    }
    
    // Allows user to cancel image picking.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Selects the image and displays it as button background.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        addPhotoButton.setTitle("", forState: UIControlState.Normal)
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        addedImage = selectedImage
        addPhotoButton.setBackgroundImage(selectedImage, forState: UIControlState.Normal)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Cancels creation of new list name, goes back to lists scene.
    @IBAction func Cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // Passes the variables of list to list scene.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let isPresentingInAddMode = presentingViewController is UINavigationController
            if isPresentingInAddMode {
                print("Adding")
                let listName = listTextField.text ?? ""
                let listImage = addedImage
                let listArray = [String]()
                list = List(name: listName, image: listImage, array: listArray)
            }
            else {
                print("Editing")
                let listName = listTextField.text ?? ""
                let listImage = addedImage
                let listArray = list?.listArray
                list = List(name: listName, image: listImage, array: listArray!)
            }
        }
    }
}


