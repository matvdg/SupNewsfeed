//
//  NewsfeedViewController.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 01/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import UIKit



var greenColor = UIColor(red: 5/255, green: 155/255, blue: 26/255, alpha: 1)


class NewsfeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //properties
    @IBOutlet weak var newsfeedTable: UITableView!
    var newsfeed = [News]()
    var nickname = UITextField()
    var pullToRefresh =  UIRefreshControl()
    var selectedPost = News()

    //@IBAction methods
    @IBAction func changeNickname(sender: AnyObject) {
        self.enterNickname()
    }
    
   
    //methodsa
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        self.navigationController?.navigationBar.tintColor = greenColor
        self.pullToRefresh.tintColor = greenColor
        self.pullToRefresh.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.newsfeedTable?.addSubview(pullToRefresh)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.refresh()
        if self.loadNickname() == nil {
            self.enterNickname()
        }
    }
    
    func refresh() {
        DaoFactory.getNewsDao().getAllNews { (data) -> Void in
            if self.pullToRefresh.refreshing
            {
                self.pullToRefresh.endRefreshing()
            }
            if let newsfeed = data {
                self.newsfeed = newsfeed
            }
            self.newsfeedTable.reloadData()
        }
    }
    
    // UITableViewDataSource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsfeed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("news", forIndexPath: indexPath)
        let news = self.newsfeed[indexPath.row]
        cell.textLabel!.text = news.title
        cell.textLabel!.textColor = UIColor.blackColor()
        cell.detailTextLabel!.textColor = greenColor
        cell.textLabel!.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel!.adjustsFontSizeToFitWidth = true
        //formatting date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE d MMMM yyy à H:mm"
        cell.detailTextLabel!.text = formatter.stringFromDate(news.date)
        return cell
    }
    
    //UITableViewDelegate method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = self.newsfeed[indexPath.row]
        self.selectedPost = post
        self.performSegueWithIdentifier("showDetails", sender: self)
    }   
    
    
    //nickname methods
    func persistNickname(alert: UIAlertAction!) {
        if self.nickname.text != "" {
            NSUserDefaults.standardUserDefaults().setObject(self.nickname.text!, forKey: "nickname")
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            // create alert controller
            let myAlert = UIAlertController(title: "Oups !", message: "Le pseudo ne peut être vide.", preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = greenColor
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                self.enterNickname()
            }))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        
    }
    
    func loadNickname() -> String? {
        if let nickname = NSUserDefaults.standardUserDefaults().objectForKey("nickname") as? String {
            return nickname
        } else {
            return nil
        }
    }
    
    func enterNickname () {
        // create alert controller
        let myAlert = UIAlertController(title: "Entrer votre pseudo", message: "Taper votre nouveau pseudonyme ou votre prénom/nom, si vous le souhaitez.", preferredStyle: UIAlertControllerStyle.Alert)
        myAlert.view.tintColor = greenColor
        // add button
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: self.persistNickname))
        //add prompt
        myAlert.addTextFieldWithConfigurationHandler(self.addNickname)
        if self.loadNickname() != nil {
            myAlert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Cancel, handler: nil))
        }
        // show the alert
        self.presentViewController(myAlert, animated: true, completion: nil)

    }
    
    func addNickname(textField: UITextField!){
        // add the text field and make the result global
        if let nickname = self.loadNickname() {
            textField.placeholder = nickname
        }
        self.nickname = textField
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        if let postVC = segue.destinationViewController as? WritePostViewController {
            // Pass the selected object to the new view controller.
            postVC.nickname = self.loadNickname()!
        }
        
        if let detailsVC = segue.destinationViewController as? ViewPostViewController {
            // Pass the selected object to the new view controller.
            detailsVC.post = self.selectedPost
        }
        
    }
    

}

