//
//  AppDelegate.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

enum AlertblackPositon {
    case middle
    case bottom
}

class Alertblack: NSObject {
    
    // MARK: 提示框
    fileprivate var alertview:UIView!
    fileprivate var alertTimer:Timer!
    fileprivate var screenWidth = UIScreen.main.bounds.size.width
    fileprivate var screenHeight = UIScreen.main.bounds.size.height
    
    func content(_ content:String?, inRect:AlertblackPositon?) {
        
        let ALERTWIDTH:CGFloat = 140
        if !UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            return
        }
        
        let reContent = content == nil ? "" : content;
        let heightLB = Alertblack.heightWithLabel(reContent! as NSString, font: UIFont(name: "Avenir-Book", size: 15)!,
                                                width: ALERTWIDTH);
        
        alertview = UIAlertView();
        if (inRect == nil || inRect == .middle) {
            alertview.frame = CGRect(x: (screenWidth-ALERTWIDTH)/2, y: (screenHeight-heightLB)/2-30, width: ALERTWIDTH, height: heightLB+20);
        }else{
            alertview.frame = CGRect(x: (screenWidth-ALERTWIDTH)/2, y: screenHeight-100, width: ALERTWIDTH, height: heightLB+20);
        }
        
        /** 动画出现前初始状态 */
        alertview.alpha = 0;
        alertview.backgroundColor = UIColor.clear;
        alertview.transform = CGAffineTransform(scaleX: 1.4, y: 1.4);
        UIApplication.shared.keyWindow?.addSubview(alertview);
        
        /** 黑色view的宽高和容器要一致 */
        let back = UIView(frame: CGRect(x: -10, y: -10, width: ALERTWIDTH+20, height: heightLB+20));
        back.backgroundColor = UIColor.black;
        back.alpha = 0.8;
        back.layer.cornerRadius = 3;
        back.clipsToBounds = true;
        alertview.addSubview(back);
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: heightLB));
        label.text = reContent! as String;
        label.numberOfLines = 0;
        label.font = UIFont(name: "Avenir-Book", size: 15);
        label.lineBreakMode = .byWordWrapping;
        label.backgroundColor = UIColor.clear;
        label.textAlignment = .center;
        label.textColor = UIColor.white;
        alertview.addSubview(label);
        
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationCurve(.easeInOut);
        UIView.setAnimationDelegate(self);
        UIView.setAnimationDidStop(#selector(Alertblack.alertAnimationDidShow));
        UIView.setAnimationDuration(0.15);
        alertview.alpha = 1;
        alertview.transform = CGAffineTransform.identity;
        UIView.commitAnimations();
    }
    
    /** 黑框显示完毕 */
    func alertAnimationDidShow() {
        alertTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Alertblack.dismissAlert(_:)), userInfo: nil, repeats: false);
    }
    
    /** 黑色框正在消失 */
    func dismissAlert(_ timer:Timer) {
        timer.invalidate();
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDuration(0.15);
        UIView.setAnimationDelegate(self);
        UIView.setAnimationDidStop(#selector(Alertblack.alertAnimationDidStop));
        UIView.setAnimationCurve(.easeInOut);
        alertview.alpha = 0;
        alertview.transform = CGAffineTransform(scaleX: 1.4, y: 1.4);
        UIView.commitAnimations();
    }
    
    /** 黑色框消失完毕 */
    func alertAnimationDidStop() {
        alertview.transform = CGAffineTransform.identity;
        alertview.removeFromSuperview();
        alertview = nil;
        UIApplication.shared.endIgnoringInteractionEvents();
    }
    
    
    // MARK: 计算文本高度 | 计算文本宽度
    class func heightWithLabel(_ text:NSString, font:UIFont, width:CGFloat)->CGFloat {
        let rect = text.boundingRect(with: CGSize(width: width, height: 10000), options: [.truncatesLastVisibleLine, .usesFontLeading, .usesLineFragmentOrigin], attributes: [NSFontAttributeName:font], context: nil);
        return rect.size.height;
    }
    
    class func widthWithLabel(_ text:NSString, font:UIFont, height:CGFloat)->CGFloat {
        let rect = text.boundingRect(with: CGSize(width: 10000, height: height), options: [.truncatesLastVisibleLine, .usesFontLeading, .usesLineFragmentOrigin], attributes: [NSFontAttributeName:font], context: nil);
        return rect.size.width;
    }

}
