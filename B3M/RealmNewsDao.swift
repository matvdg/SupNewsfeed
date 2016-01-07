//
//  RealmNewsDao.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 01/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNewsDao: NewsDao {
    
    let realm = try! Realm()
    
    func getAllNews(callback: ([News]?)-> Void) {
        DaoFactory.getDistantNewsDao().getAllNews { (data) -> Void in
            if let newsfeed = data {
                //online mode -> update Realm persisted objects
                try! self.realm.write() {
                    self.realm.delete(self.realm.objects(News))
                    //print("realm db cleaned")
                    for post in newsfeed {
                        self.realm.add(post)
                    }
                    //print("realm db updated")
                }
                callback(newsfeed)
            } else {
                //offline mode -> fetch Realm persisted objects
                let newsfeed: [News] = Array(self.realm.objects(News))
                callback(newsfeed)
            }
            
        }
        
    }
    
    func postNews(news: News, callback: (success: Bool) -> Void) {
        DaoFactory.getDistantNewsDao().postNews(news) { (success) -> Void in
            callback(success: success)
        }
    }
    
}