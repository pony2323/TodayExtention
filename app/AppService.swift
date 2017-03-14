//
//  AppDelegate.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

enum UseWXSource {
    case login
    case bind
}

class AppService: NSObject {
    
    static let instance = AppService()
    class func shareInstance() -> AppService {
        return instance
    }

}
