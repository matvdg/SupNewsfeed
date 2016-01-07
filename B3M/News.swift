//
//  News.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 01/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//


import Foundation
import RealmSwift

// News model
class News : Object {
    dynamic var id: Int = 0
    dynamic var author: String = ""
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var date: NSDate = NSDate()
}