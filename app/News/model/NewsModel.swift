//
//  NewsModel.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    
    // 新闻
    var image   = ""
    var title   = ""
    
    // 默认值处理
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            image = Common.unpackOptionalParam(param: value)
        } else if key == "attrName" {
            title = Common.unpackOptionalParam(param: value)
        }
        
    }
    
    // KVC 转对象
    class func obtainNewsModelWith(dic:NSDictionary) -> NewsModel {
        let model = NewsModel()
        model.setValuesForKeys(dic as! [String : AnyObject])
        return model
    }
    
    class func obtainNewsModelsWith(dicArr: NSArray) -> [NewsModel] {
        var models = [NewsModel]()
        for i in 0..<dicArr.count {
            let model = NewsModel()
            model.setValuesForKeys(dicArr[i] as! [String : AnyObject])
            models.append(model)
        }
        return models
    }
    
    deinit {
        print("NewsModel dealloc")
    }
}
