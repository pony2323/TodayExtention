//
//  NewsViewModel.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

class NewsViewModel: NSObject {

    static let instance = NewsViewModel()
    class func shareInstance() -> NewsViewModel {
        return instance
    }
    
    // data
    var newListData = [NewsModel]()
    
    // request data
    // MARK:  新闻列表
    func obtainNewsList(_ callBack:@escaping CallBack) {
        NetworkAPI.postNewsListData() { (data, result) in
            if let dic = data as? NSDictionary {
                self.newListData = NewsModel.obtainNewsModelsWith(dicArr: dic["list"] as! NSArray)
            }
            callBack(data, result)
        }
    }
}
