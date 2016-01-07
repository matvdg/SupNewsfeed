//
//  ViewPostViewController.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 03/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import UIKit

class ViewPostViewController: UIViewController {
    
    var post = News()
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.post.title
        self.content.textAlignment = NSTextAlignment.Justified
        self.author.text = "by " + self.post.author
        self.content.text = self.post.content
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE d MMMM yyy à H:mm"
        self.date.text = "le " + formatter.stringFromDate(self.post.date)
        self.date.textColor = greenColor
    }
}
