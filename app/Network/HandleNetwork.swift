//
//  AppDelegate.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

enum Result: String {
    case success = "友情提示 \n 请求成功"
    case backErr = "友情提示 \n 返回错误信息"
    case netFail = "友情提示 \n 请检查网络环境是否正常"
}

enum RequestType {
    case post
    case get
    case put
    case delete
}

class HandleNetwork: NSObject {
    typealias CallBackSuccess = (AnyObject?, Result) -> Void
    typealias CallBackFail    = (NSError?, Result) -> Void

    // MARK:  post and get 请求
    /// - parameter requestType:     请求方式
    /// - parameter url:             请求地址
    /// - parameter body:            请求参数
    /// - parameter callBackSuccess: 请求成功回调
    /// - parameter callBackFailure: 请求失败回调
    
    class func handle(_ requestType:RequestType, url:NSString, body:Any?, callBackSuccess:@escaping CallBackSuccess, callBackFailure:@escaping CallBackFail) -> Void {
        
        // 1.获得请求管理者
        let manager = AFHTTPSessionManager()
        
        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 30
        manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        
        // 2.网络数据形式
        // 设置响应数据支持类型
        // 保持JSON格式
        manager.responseSerializer = AFXMLParserResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/xml", "text/xml", "text/javascript","text/html","text/css","text/plain", "application/javascript") as? Set<String>
        manager.requestSerializer = AFJSONRequestSerializer()
        
        // 请求头设置
        manager.requestSerializer.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        manager.requestSerializer.setValue(UserDefaults.standard.object(forKey: "token") as? String, forHTTPHeaderField: "token")
        manager.requestSerializer.setValue(UserDefaults.standard.object(forKey: "userId") as? String, forHTTPHeaderField: "currentuserid")
        
        // 3.将url进行文字处理
        var url = url
        if #available(iOS 9, *) {
            url = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        } else {
            url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! as NSString
        }
        
        // 4.开始请求
        switch requestType {
        case .post:
            manager.post(url as String,
                         parameters: body,
                         progress: nil,
                         success: { (task, data) in
                                    print("\(url): \(data)")
                                    switch data {
                                    case is NSDictionary:
                                    if ErrorModel.judgeData(data as! NSDictionary?).0 {
                                        callBackSuccess(data as AnyObject?, .success)
                                    } else {
                                        callBackSuccess(data as AnyObject?, .backErr)
                                    }
                                    default:
                                        callBackSuccess(data as AnyObject?, .success)
                                    }
                },
                         failure: { (task, error) in
                                    print("\(url): \(error)")
                                    // Alertblack().content(Result.netFail.rawValue, inRect: .bottom)
                                    callBackFailure(error as NSError?, .netFail)
            })
        case .get:
            manager.get(url as String,
                        parameters: body,
                        progress: nil,
                        success: { (task, data) in
                                    print("\(url): \(data)")
                                    switch data {
                                    case is NSDictionary:
                                    if ErrorModel.judgeData(data as! NSDictionary?).0 {
                                        callBackSuccess(data as AnyObject?, .success)
                                    } else {
                                        callBackSuccess(data as AnyObject?, .backErr)
                                        }
                                    default:
                                        callBackSuccess(data as AnyObject?, .success)
                                    }
                },
                        failure: { (task, error) in
                                    print("\(url): \(error)")
                                    // Alertblack().content(Result.netFail.rawValue, inRect: .bottom)
                                    callBackFailure(error as NSError?, .netFail)
            })
        case .put:
            manager.put(url as String,
                        parameters: body,
                        success: { (task, data) in
                            print("\(url): \(data)")
                            switch data {
                            case is NSDictionary:
                            if ErrorModel.judgeData(data as! NSDictionary?).0 {
                                callBackSuccess(data as AnyObject?, .success)
                            } else {
                                callBackSuccess(data as AnyObject?, .backErr)
                            }
                            default:
                                callBackSuccess(data as AnyObject?, .success)
                            }
                },
                        failure: { (task, error) in
                            print("\(url): \(error)")
                            // Alertblack().content(Result.netFail.rawValue, inRect: .bottom)
                            callBackFailure(error as NSError?, .netFail)
            })
        case .delete:
            manager.delete(url as String,
                           parameters: body,
                           success: { (task, data) in
                                print("\(url): \(data)")
                                switch data {
                                case is NSDictionary:
                                if ErrorModel.judgeData(data as! NSDictionary?).0 {
                                    callBackSuccess(data as AnyObject?, .success)
                                } else {
                                    callBackSuccess(data as AnyObject?, .backErr)
                                }
                                default:
                                    callBackSuccess(data as AnyObject?, .success)
                                }
                },
                        failure: { (task, error) in
                            print("\(url): \(error)")
                            // Alertblack().content(Result.netFail.rawValue, inRect: .bottom)
                            callBackFailure(error as NSError?, .netFail)
            })
        }
        manager.reachabilityManager.startMonitoring()
    }
    
    
    /// MARK: 图片上传
    /// - parameter url:             请求地址
    /// - parameter body:            请求参数
    /// - parameter name:            上传文件名字
    /// - parameter data:            上传图片流
    /// - parameter callBackSuccess: 请求成功回调
    /// - parameter callBackFailure: 请求失败回调
    
    class func uploadImage(_ url: String, body: NSDictionary?, name:String, data:Data, callBackSuccess:@escaping CallBackSuccess, callBackFailure:@escaping CallBackFail) {
        
        // 1.获得请求管理者
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 30
        manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        
        // 2.网络数据形式
        // 设置响应数据支持类型
        // 保持JSON格式
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript") as? Set<String>
        manager.requestSerializer.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        // 请求头设置
        manager.requestSerializer.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        manager.requestSerializer.setValue(UserDefaults.standard.object(forKey: "token") as? String, forHTTPHeaderField: "token")
        manager.requestSerializer.setValue(UserDefaults.standard.object(forKey: "userId") as? String, forHTTPHeaderField: "currentuserid")
        
        // 3.发送请求
        manager.post(url, parameters: body, constructingBodyWith: { (formData) -> Void in
            let imgData = data
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            let timeStr = formatter.string(from: Date())
            let fileName = timeStr+".png"
            formData.appendPart(withFileData: imgData,
                                name: name,
                                fileName: fileName,
                                mimeType: "image/png")
            }, progress: nil,
                    success: { (dataTask, data) -> Void in
                        print("\(url): \(data)")
                        if ErrorModel.judgeData(data as! NSDictionary?).0 {
                            callBackSuccess(data as AnyObject?, .success)
                        } else {
                            callBackSuccess(data as AnyObject?, .backErr)
                        }
        }) { (dataTask, error) -> Void in
                        print("\(url): \(error)")
                        // Alertblack().content(Result.netFail.rawValue, inRect: .bottom)
                        callBackFailure(error as NSError?, .netFail)
        }
    }
}

class ErrorModel: NSObject {
    
    // 错误对象属性
    var aresponCode    = "1"
    var aresponMessage = "1"
    var asuccess       = "1"
    var aresultMsg     = ""
    var acode          = "1"
    var amessage       = "1"
    
    // 默认值处理
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "responCode" {
            aresponCode = self.unpackOptionalParam(param: value)
        } else if key == "responMessage" {
            aresponMessage = self.unpackOptionalParam(param: value)
        } else if key == "success" {
            asuccess = self.unpackOptionalParam(param: value)
        } else if key == "resultMsg" {
            aresultMsg = self.unpackOptionalParam(param: value)
        } else if key == "code" {
            acode = self.unpackOptionalParam(param: value)
        } else if key == "message" {
            amessage = self.unpackOptionalParam(param: value)
        }
    }
    
    // KVC
    class func obtainBaseErrorModelWithDic(_ dic:NSDictionary?) -> ErrorModel {
        let model = ErrorModel()
        model.setValuesForKeys(dic as! [String : AnyObject])
        return model
    }
    
    class func judgeData(_ dic:NSDictionary?) -> (Bool, String) {
        let model = ErrorModel.obtainBaseErrorModelWithDic(dic)
        
        if model.asuccess == "0" {
            Alertblack().content(model.aresultMsg, inRect: .middle)
            return (false, model.aresponMessage)
        }
        if model.acode != "1" {
            if model.acode == "200" {
                if  model.amessage == "" {
                    return (false, "fail to load stock data")
                }
            }
            if model.acode != "200" {
                return (false, "fail to load stock data")
            }
        }
        if model.aresponCode == "011" {
//            NetLogin.presentLoginView()
        }
        if model.aresponCode == "000" || model.aresponCode == "004" || model.aresponCode == "1" {
            if  model.amessage == "" || model.aresponMessage == "" {
                return (false, "fail to load stock data")
            }
            return (true, "")
        } else {
            Alertblack().content(model.aresponMessage, inRect: .middle)
            return (false, model.aresponMessage)
        }
    }
    
    // 解包
    func unpackOptionalParam(param: Optional<Any>) -> String {
        if let value = param {
            return String(describing: value)
        }else{
            return ""
        }
    }
}

