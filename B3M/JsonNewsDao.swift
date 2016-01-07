//
//  JsonNewsDao.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 01/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import Foundation


class JsonNewsDao: NewsDao {
    
    let apiUrl = NSURL(string: "http://prep-app.com/api/articles/")
    
    func getAllNews(callback: ([News]?)-> Void) {
        
        var newsfeed = [News]()
        let request = NSMutableURLRequest(URL: apiUrl!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    print("newsfeed offline")
                    callback(nil)
                } else {
                    let statusCode = (response as! NSHTTPURLResponse).statusCode
                    if statusCode == 200 {
                        let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                        if let result = jsonResult {
                            for data in result {
                                if let news = data as? NSDictionary {
                                    let newPost = News()
                                    newPost.id = news["id"] as! Int
                                    newPost.title = news["title"] as! String
                                    newPost.author = news["author"] as! String
                                    newPost.content = news["content"] as! String
                                    let dateFormatter = NSDateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    newPost.date = dateFormatter.dateFromString(news["createdAt"] as! String)!
                                    newsfeed.append(newPost)
                                }
                            }
                            callback(newsfeed)
                        } else {
                            print("error : NSArray nil in retrieveNewsfeed")
                            callback(nil)
                        }
                    } else {
                        print("header status = \(statusCode) in retrieveNewsfeed")
                        callback(nil)
                    }
                }
            }
        }
        task.resume()
    }
    
    func postNews(news: News, callback: (success: Bool) -> Void) {
        
        let request = NSMutableURLRequest(URL: apiUrl!)
        request.HTTPMethod = "POST"
        let postString = "author=\(news.author)&title=\(news.title)&content=\(news.content)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    print("you're offline")
                    callback(success: false)
                } else {
                    print("post sent successfully!")
                    callback(success: true)
                }
            }
        }
        task.resume()
    }
    
}