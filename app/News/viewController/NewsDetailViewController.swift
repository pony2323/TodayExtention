//
//  NewsDetailViewController.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

class NewsDetailViewController: BaseViewController {

    private var webview = UIWebView()
    
    var urlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView()
    }
    
    private func drawView() {
        webview = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webview)
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        webview.loadRequest(request)
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
