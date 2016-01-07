//
//  NewsDao.swift
//  B3M
//
//  Created by Mathieu Vandeginste on 01/01/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import Foundation

protocol NewsDao {
    
    
    func getAllNews(callback: ([News]?)-> Void)
    
    func postNews(news: News, callback: (success: Bool) -> Void)
    
}


