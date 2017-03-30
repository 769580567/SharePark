//
//  recordView_Cell.swift
//  IPMS
//
//  Created by air on 2017/3/28.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

class recordView_Cell: UITableViewCell {
    
    
    lazy var coverImage:UIImageView = {
        let coverImage = UIImageView()
        coverImage.layer.cornerRadius = 25
        coverImage.layer.masksToBounds = true
        return coverImage
    }()
    lazy var typeLabel = UILabel()
    lazy var numberLabel = UILabel()
    lazy var costLabel = UILabel()
    lazy var timeLabel = UILabel()
    lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 226/255, green: 188/255, blue: 123/255, alpha: 1)
        return lineView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.contentView.addSubview(coverImage)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(costLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(lineView)
        setupViewsConstraints()
    }
    
    func setupViewsConstraints() {
        coverImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(5)
            make.leading.equalTo(self.contentView).offset(8)
            make.width.height.equalTo(70)
        }
        typeLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(self.contentView).offset(8)
            make.leading.equalTo(coverImage.snp.trailing).offset(8)
            make.height.equalTo(10)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.leading.trailing.height.equalTo(typeLabel)
        }
        costLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberLabel.snp.bottom).offset(8)
            make.leading.trailing.height.equalTo(typeLabel)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(costLabel.snp.bottom).offset(8)
            make.leading.trailing.height.equalTo(typeLabel)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(30)
            make.trailing.equalTo(self.contentView).offset(-30)
            make.height.equalTo((2.0 / UIScreen.main.scale))
            make.bottom.equalTo(self.contentView).offset(-2)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
