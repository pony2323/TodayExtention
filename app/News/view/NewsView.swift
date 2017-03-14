//
//  NewsView.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

class NewsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    // 回调
    var callbackToLoadNews = { () -> Void in }
    var callbackIntoNewsDetail = { (news:NewsModel) -> Void in }
    
    // 视图
    var table:UITableView!
    
    // 模型
    var listData = [NewsModel]() {
        didSet {
            table.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // MARK: 创建视图
    private func setupUI() {
        
        // Table
        table = UITableView(frame: CGRect(x: 0, y: 0, width: screen_width, height: self.bounds.height), style: .plain)
        table.showsVerticalScrollIndicator = false
        table.separatorColor = sepLineColor
        table.backgroundColor = allBackColor
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 120
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: 0.5))
        footerView.backgroundColor = sepLineColor
        table.tableHeaderView = UIView()
        table.tableFooterView = footerView
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsTableIdentifier")
        self.addSubview(table)
        
        // 新闻下拉刷新
        let header = MJRefreshNormalHeader {
            self.callbackToLoadNews()
        }
        table.mj_header = header
        header?.lastUpdatedTimeLabel.isHidden = true
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableIdentifier", for: indexPath) as! NewsTableViewCell
        cell.backgroundColor = .white
        cell.model = listData[indexPath.row]
        return cell
    }
    
    // MARK: UITableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        callbackIntoNewsDetail(listData[indexPath.row])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
