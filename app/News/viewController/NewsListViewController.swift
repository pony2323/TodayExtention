//
//  NewsListViewController.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

class NewsListViewController: BaseViewController {

    // 视图
    private var newsView:NewsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initNewsModel()
        
    }
    
    // MARK: 请求新闻列表数据
    private func initNewsModel() {
        NewsViewModel.shareInstance().obtainNewsList{ (data, result) in
            self.newsView.table?.mj_header.endRefreshing()
            if result == .success {
                self.newsView.listData = NewsViewModel.shareInstance().newListData
            }
        }
    }
    
    // MARK: 创建视图
    private func setupUI() {
        newsView = NewsView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height-CGFloat(navi_h)-tabbar_h))
        newsView.callbackToLoadNews = {()->Void in
            self.initNewsModel()
        }
        newsView.callbackIntoNewsDetail = { (news) -> Void in
            let newsDetail = NewsDetailViewController()
            newsDetail.urlStr = news.title
            newsDetail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(newsDetail, animated: true)
        }
        self.view.addSubview(newsView)
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
