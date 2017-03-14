//
//  NewsTableViewCell.swift
//  app
//
//  Created by  cos on 17/3/13.
//  Copyright © 2017年 pony. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // 视图
    private var newsImage:UIImageView!
    private var titleName:UILabel!
    private var detailTitle:UILabel!
    
    var model = NewsModel() {
        didSet{
            newsImage.image = UIImage(named: model.image)
            titleName.text = model.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        self.contentView.addSubview(newsImage)
        
        titleName = UILabel()
        titleName.textColor = baseColor
        titleName.font = Common.baseFontWith(size: 14)
        titleName.textAlignment = .left
        self.contentView.addSubview(titleName)
        
        detailTitle = UILabel()
        detailTitle.textColor = baseColor
        detailTitle.font = Common.baseFontWith(size: 14)
        detailTitle.textAlignment = .left
        self.contentView.addSubview(detailTitle)
        
        newsImage.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.newsImage.mas_right)?.equalTo()(15)
            _ = make?.bottom.and().top().mas_equalTo()(self.contentView)
            _ = make?.width.mas_equalTo()(80)
        }
        titleName.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.newsImage.mas_right)?.equalTo()(15)
            _ = make?.right.mas_equalTo()(self.contentView)?.equalTo()(15)
            _ = make?.top.mas_equalTo()(self.contentView)?.equalTo()(10)
            _ = make?.bottom.mas_equalTo()(self.detailTitle)
            _ = make?.height.mas_equalTo()(40)
           
        }
        detailTitle.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.newsImage.mas_right)?.equalTo()(15)
            _ = make?.right.mas_equalTo()(self.contentView)?.equalTo()(15)
            _ = make?.top.mas_equalTo()(self.titleName)?.equalTo()(10)
            _ = make?.bottom.mas_equalTo()(self.contentView)?.equalTo()(10)
            _ = make?.height.mas_equalTo()(50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

