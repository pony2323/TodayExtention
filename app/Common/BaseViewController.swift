//
//  AppDelegate.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
///

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = allBackColor
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
        UINavigationBar.appearance().tintColor = .white
        
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navi_back")?.withRenderingMode(.automatic), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // 透明度并去掉底部一像素线条
    func setTransparentNavi() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    // 标题颜色
    func setStyleFontNavi(_ color:String, alpha:CGFloat, font:String, size:CGFloat) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: font, size: size)!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackStyle()
    }
    
    // 设置导航栏返回键
    func setBackStyle() {
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            let backButton = UIButton(type: .custom)
            backButton.frame = CGRect(x: 5, y: 2, width: 58, height: 40)
            
            backButton.setTitle("返回", for: UIControlState())
            backButton.imageEdgeInsets = UIEdgeInsetsMake(10, -7, 10, 55)
            backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
            let leftItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = leftItem
            
            // 设置leftBarButtonItem后右滑返回上个界面手势会消失，在次处理
            if ((self.navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer))) != nil) {
                self.navigationController!.interactivePopGestureRecognizer!.delegate = nil;
            }
        }
    }
    
    // 点击空白处回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 返回
    @objc func backAction(_ sender:UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
