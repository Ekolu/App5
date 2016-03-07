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
        /*
        self.iconView.layer.cornerRadius = self.iconView.frame.size.width / 2;
        self.iconView.clipsToBounds = YES;
        self.iconView.layer.borderWidth = 3.0f;
        self.iconView.layer.borderColor = [UIColor whiteColor].CGColor;
        configureButton()
        */

        // Do any additional setup after loading the view, typically from a nib.
        configureButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var listTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //
    var list: List?
    var addedImage: UIImage?
    
    
    
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
    
    // Displays the selected image as button background.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        addPhotoButton.setTitle("", forState: UIControlState.Normal)
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        addedImage = selectedImage
        addPhotoButton.setBackgroundImage(selectedImage, forState: UIControlState.Normal)
        dismissViewControllerAnimated(true, completion: nil)
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
    

    func configureButton() {
        photoButton.layer.cornerRadius = photoButton.bounds.size.width / 2.0
        photoButton.layer.masksToBounds = true
        photoButton.layer.borderColor = UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:1).CGColor as CGColorRef
        photoButton.layer.borderWidth = 2.0
        photoButton.clipsToBounds = true
        photoButton.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let listName = listTextField.text ?? ""
            let listImage = addedImage
            let listArray = [String]()
            list = List(name: listName, image: listImage, array: listArray)
        }
    }
    
    @IBAction func Cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        configureButton()
        configureList()
    }

}


