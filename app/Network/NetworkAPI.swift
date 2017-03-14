//
//  AppDelegate.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

typealias CallBack = (AnyObject?, Result) -> Void

class NetworkAPI: NSObject {
    
    static let instance = NetworkAPI()
    class func shareInstance() -> NetworkAPI {
        return instance
    }
    
    // MARK: 新闻
    static func postNewsListData(_ callBack:@escaping CallBack) {
        let url = "" + "http://techcrunch.cn/feed/"//"/TechCrunch/startups"
        let param = ["channel": "news_toutiao"]
        HandleNetwork.handle(.post, url: url as NSString, body: nil , callBackSuccess: { (data, result) in
            callBack(data, result)
        }) { (error, result) in
            callBack(error as AnyObject?, result)
        }
    }
    
}
