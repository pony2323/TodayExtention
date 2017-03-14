//
//  AppDelegate.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

// MARK: 背景颜色和主色调
let allBackColor        = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
let lineInDarkColor     = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 0.2)
let naviColor           = UIColor(red: 0/255.0, green: 13/255.0, blue: 26/255.0, alpha: 1)
let baseColor           = UIColor(red: 0/255.0, green: 13/255.0, blue: 26/255.0, alpha: 0.85)
let sepLineColor        = UIColor(red: 0/255.0, green: 13/255.0, blue: 26/255.0, alpha: 0.85)

// MARK: 屏幕宽度 高度 导航高度
let screen_width  = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height
let navi_h = 64.0
let tabbar_h:CGFloat = 49.0

// MARK: 数字字体
let DigitFont = "Avenir-Book"
let StockFont = "ArialMT"
let DigitBoldFont = "Avenir-Medium"

class Common: NSObject {
    
    // MARK: 普通字体
    static func baseFontWith(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    // MARK: 加粗字体
    static func baseBoldFontWith(size:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    // MARK: 加粗数字字体
    static func baseBoldDigitFontWith(size:CGFloat) -> UIFont {
        return UIFont(name: DigitBoldFont, size: size)!
    }
    
    // MARK: 颜色转化
    static func RGBA(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: alpha/255.0, alpha: alpha)
    }
    
    // MARK: 解包
    static func unpackOptionalParam(param: Optional<Any>) -> String {
        if let value = param {
            return String(describing: value)
        }else{
            return ""
        }
    }
    
    // MARK: 弹出登录界面
    static func presentLoginView(vc:UIViewController) {
        let naviLogin = UINavigationController(rootViewController: vc)
        let tabBar = ((UIApplication.shared.delegate as! AppDelegate)).window?.rootViewController
        tabBar?.present(naviLogin, animated: true, completion: nil)
    }
    
    // MARK: 验证手机号
    static func validTelephone(_ num:String?) -> (Bool, String) {
        let error = "手机号码格式不正确"
        if let str = num {
            let regex = "^(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$";
            let pre = NSPredicate(format: "SELF MATCHES %@", regex);
            let isMatch:Bool = pre.evaluate(with: str);
            if !isMatch {
                return (false, error)
            } else {
                return (true, error)
            };
        }
        return (false, error)
    }
    
    // MARK: 密码必须为6-16位字母加数字组成
    static func validPassword(_ num:String?) -> (Bool, String) {
        let error = "密码必须为6-16位字母加数字组成"
        if let str = num {
            let regex = "(?![^a-zA-Z]+$)(?!\\D+$).{6,16}$";
            let pre = NSPredicate(format: "SELF MATCHES %@", regex);
            let isMatch:Bool = pre.evaluate(with: str);
            if !isMatch {
                return (false, error)
            } else {
                return (true, "")
            }
        }
        return (false, error)
    }
    
    // MARK: 金额等逗号数字格式｜含小数点
    static  func appendCommaWithNumber(_ num:Double) -> String {
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.positiveFormat = "###,##0.00"
        var str = String()
        str = numberFormatter1.string(from: NSNumber(value: num as Double))!
        return str
    }
    
    // MARK: 百分比显示
    static func percentFormatWith(_ numStr:String) -> String {
        let num = (Double(numStr) ?? 0)
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.positiveFormat = "###,##0.00"
        var str = String()
        str = numberFormatter1.string(from: NSNumber(value: num as Double))!
        return str+"%"
    }
    
    // MARK: 取余两位
    static func leaveTwoFormatWith(_ numStr:String) -> String {
        let num = (Double(numStr) ?? 0)
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.positiveFormat = "###,##0.00"
        var str = String()
        str = numberFormatter1.string(from: NSNumber(value: num as Double))!
        return str
    }
    
    // MARK: 金额等逗号数字格式｜不含小数点
    static func saveTwoPointWithNumber(_ numStr:String) -> String {
        let num = (Double(numStr) ?? 0)
        let numberFormatter1 = NumberFormatter()
        numberFormatter1.positiveFormat = "#####0.00"
        var str = String()
        str = numberFormatter1.string(from: NSNumber(value: num as Double))!
        return str
    }
    
    // MARK: 计算文本高度
    static func heightWithLabel(_ text:NSString, font:UIFont, width:CGFloat)->CGFloat {
        let rect = text.boundingRect(with: CGSize(width: width, height: 10000), options: [.truncatesLastVisibleLine, .usesFontLeading, .usesLineFragmentOrigin], attributes: [NSFontAttributeName:font], context: nil);
        return rect.size.height;
    }
    
    // MARK: 计算文本宽度
    static func widthWithLabel(_ text:NSString, font:UIFont, height:CGFloat)->CGFloat {
        let rect = text.boundingRect(with: CGSize(width: 10000, height: height), options: [.truncatesLastVisibleLine, .usesFontLeading, .usesLineFragmentOrigin], attributes: [NSFontAttributeName:font], context: nil);
        return rect.size.width;
    }
    
    // MARK: 获取本地时间 年 月 日 yyyy-MM-dd
    static func getLocalDate() -> String {
        var date:NSDate = NSDate()
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        let second:Int = zone.secondsFromGMT
        date = date.addingTimeInterval(TimeInterval(second))
        
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 10)
        let dateStr = "\(date)".substring(to: index)
        return dateStr
    }
    
    // MARK: 获取本地时间 年 月 日 时 分 秒 yyyy-MM-dd HH-mm-ss
    static func getLocalFullDateTime() -> String {
        var date:NSDate = NSDate()
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        let second:Int = zone.secondsFromGMT
        date = date.addingTimeInterval(TimeInterval(second))
        
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 19)
        let dateStr = "\(date)".substring(to: index)
        return dateStr
    }
    
    // MARK: 获取今天以前某天时间 yyyy-MM-dd
    static func getLastDate(days:Int) -> String {
        var date:NSDate = NSDate()
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        let second:Int = zone.secondsFromGMT
        date = date.addingTimeInterval(TimeInterval(second-days*24*60*60))
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 10)
        let dateStr = "\(date)".substring(to: index)
        return dateStr
    }
    
    // MARK: 获取本地时间 年 月 日 yyyyMMdd
    static func getLocalDateNoSep() -> String {
        var date:NSDate = NSDate()
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        let second:Int = zone.secondsFromGMT
        date = date.addingTimeInterval(TimeInterval(second))
        
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 10)
        var dateStr = "\(date)".substring(to: index)
        dateStr = dateStr.replacingOccurrences(of: "-", with: "")
        return dateStr
    }
    
    // MARK: 获取今天以前某天时间 yyyyMMdd
    static func getLastDateNoSep(days:Int) -> String {
        var date:NSDate = NSDate()
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        let second:Int = zone.secondsFromGMT
        date = date.addingTimeInterval(TimeInterval(second-days*24*60*60))
        let index = "\(date)".index("\(date)".startIndex, offsetBy: 10)
        var dateStr = "\(date)".substring(to: index)
        dateStr = dateStr.replacingOccurrences(of: "-", with: "")
        return dateStr
    }
    
    // MARK: 时间格式分割
    static func separateDateTime(_ dateStr:String) -> [String] {
        var dateTime = ["", ""]
        var date = ""
        var time = ""
        if dateStr.characters.count > 10 {
            date = dateStr.substring(to: dateStr.index(dateStr.startIndex, offsetBy: 10))
            dateTime[0] = date
        }
        if dateStr.characters.count > 16 {
            let startIndex = dateStr.index(dateStr.startIndex, offsetBy: 11)
            let endIndex = dateStr.index(dateStr.startIndex, offsetBy: 16)
            let range = Range(startIndex..<endIndex)
            time = dateStr.substring(with: range)
            dateTime[1] = time
        }
        return dateTime
    }
    
    // MARK: 手机号码部分隐藏
    static func hidePhoneNum(_ num:String?) -> String {
        if num == nil {
            return "信息有误，请联系客服!"
        } else {
            if num! == "" || (num?.characters.count)! < 11 {
                return "信息有误，请联系客服!"
            } else {
                var numStr = num!
                numStr.replaceSubrange((numStr.characters.index(numStr.startIndex, offsetBy: 3) ..< (num?.characters.index((num?.endIndex)!, offsetBy: -4))!), with: " **** ")
                return numStr
            }
        }
    }
    
    // MARK: 银行卡号部分隐藏
    static func hideBandCardNum(_ num:String?) -> String {
        if num == nil {
            return "信息有误，请联系客服!"
        } else {
            if num! == "" || (num?.characters.count)! < 10 {
                return "信息有误，请联系客服!"
            } else {
                var numStr = num!
                numStr.replaceSubrange((numStr.characters.index(numStr.startIndex, offsetBy: 4) ..< (num?.characters.index((num?.endIndex)!, offsetBy: -4))!), with: " **** **** ")
                return numStr
            }
        }
    }
    
    // MARK: 加载图片
    static func loadImgs() -> [UIImage] {
        var imgs = [UIImage]()
        for i in 1...24 {
            if i%3 == 0 {
                imgs.append(UIImage(named: "refresh\(i)")!)
            }
        }
        return imgs
    }
    
    // MARK: 数字以K划分
    static func sepKWithNum(_ num:String?) -> String {
        if num?.isEmpty == true {
            return "0"
        }
        if (Double(num!) ?? 0) < 1000 {
            return num!
        }
        if (Double(num!) ?? 0) > 1000 {
            let numberFormatter1 = NumberFormatter()
            numberFormatter1.positiveFormat = "##0.00"
            let str = numberFormatter1.string(from: NSNumber(value: (Double(num!) ?? 0)/1000))!
            return "\(str)k"
        }
        return "0"
    }
    
    // MARK: 图片尺寸转化
    static func originImage(_ image:UIImage, size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaleImage!
    }
    
}

// MARK: Date: 时间
extension Date {
    var str:String! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        var dateStr = ""
        dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}

