//
//  WritePostViewController.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 03/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import UIKit

class WritePostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    var nickname = ""
    
    @IBAction func post(sender: AnyObject) {
        if self.postContent.text == "Taper votre commentaire ici :" || self.postContent.text == "" || self.postTitle.text == "" {
            // create alert controller
            let myAlert = UIAlertController(title: "Erreur", message: "Veillez à bien remplir les deux champs !", preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = greenColor
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)
        } else {
            let post = News()
            post.author = self.nickname
            post.title = self.postTitle.text!
            post.content = self.postContent.text
            DaoFactory.getNewsDao().postNews(post, callback: { (success) -> Void in
                if success { //message sent
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else { //error
                    let myAlert = UIAlertController(title: "Erreur", message: "Vérifier votre connexion et réessayez.", preferredStyle: UIAlertControllerStyle.Alert)
                    myAlert.view.tintColor = greenColor
                    // add "OK" button
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    // show the alert
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postContent.text = "Taper votre texte ici..."
        self.postContent.textColor = UIColor.lightGrayColor()
        self.postButton.backgroundColor = greenColor
        self.postButton.layer.cornerRadius = 6
        self.postButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.dismissButton.backgroundColor = UIColor.redColor()
        self.dismissButton.layer.cornerRadius = 6
        self.dismissButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //UITextViewDelegate Methods
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Taper votre texte ici..."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
