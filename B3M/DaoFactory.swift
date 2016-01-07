//
//  DaoFactory.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 01/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import Foundation

class DaoFactory {
    
    static func getNewsDao() -> NewsDao {
        return RealmNewsDao()
    }
    
    static func getDistantNewsDao() -> NewsDao {
        return JsonNewsDao()
    }
    
}