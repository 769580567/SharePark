//
//  LeaseView_Cell.swift
//  IPMS
//
//  Created by air on 2017/3/28.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

class LeaseView_Cell: UITableViewCell {
    
    
    lazy var coverImage:UIImageView = {
        let coverImage = UIImageView()
        coverImage.layer.cornerRadius = 25
        coverImage.layer.masksToBounds = true
        return coverImage
    }()
    lazy var nameLabel:UILabel = {
        let  nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textColor = UIColor.brown
        return nameLabel
    }()
    
    lazy var numberLabel:UILabel = {
       let numberLabel = UILabel()
        numberLabel.font = UIFont.systemFont(ofSize: 16)
        numberLabel.textColor = UIColor.blue.withAlphaComponent(0.5)
        return numberLabel
    }()
    lazy var costLabel:UILabel = {
        let costLabel = UILabel()
        costLabel.font = UIFont.systemFont(ofSize: 14)
        costLabel.textColor = UIColor.red.withAlphaComponent(0.5)
        return costLabel
    }()
    lazy var timeLabel:UILabel = {
       let timerLabel = UILabel()
        timerLabel.font = UIFont.systemFont(ofSize: 12)
        timerLabel.textColor = UIColor.brown
       return timerLabel
    }()
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
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(costLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(lineView)
        setupViewsConstraints()
    }
    
    func setupViewsConstraints() {
        coverImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(5)
            make.leading.equalTo(self.contentView).offset(12)
            make.width.height.equalTo(80)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(self.contentView).offset(12)
            make.leading.equalTo(coverImage.snp.trailing).offset(8)
            make.height.equalTo(14)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nameLabel)
            make.height.equalTo(10)
        }
        costLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nameLabel)
            make.height.equalTo(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(costLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nameLabel)
            make.height.equalTo(8)
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
