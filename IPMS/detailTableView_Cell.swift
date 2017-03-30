//
//  detailTableViewCell.swift
//  IPMS
//
//  Created by air on 2017/3/28.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit

class detailTableView_Cell: UITableViewCell {

    lazy var firstLabel:UILabel = {
        let  firstLabel = UILabel()
        firstLabel.font = UIFont.systemFont(ofSize: 20)
        firstLabel.textColor = UIColor.brown
        return firstLabel
    }()
    
    lazy var secondLabel:UILabel = {
        let secondLabel = UILabel()
        secondLabel.font = UIFont.systemFont(ofSize: 20)
        secondLabel.textColor = UIColor.red.withAlphaComponent(0.5)
        return secondLabel
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
        
        self.contentView.addSubview(firstLabel)
        self.contentView.addSubview(secondLabel)
        self.contentView.addSubview(lineView)

        setupViewsConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewsConstraints() {
        firstLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView).offset(5)
            make.leading.equalTo(self.contentView).offset(15)
            make.width.equalTo(90)
        }
        secondLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(firstLabel)
            make.leading.equalTo(firstLabel.snp.trailing).offset(3)
            make.trailing.equalTo(self.contentView).offset(-15)
        }
        lineView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(30)
            make.trailing.equalTo(self.contentView).offset(-30)
            make.height.equalTo((2.0 / UIScreen.main.scale))
            make.bottom.equalTo(self.contentView).offset(-2)
        }
    }

}
