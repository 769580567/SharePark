//
//  moreView_Cell.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import SnapKit

class moreView_Cell: UITableViewCell {
    
    
    lazy var coverImage:UIImageView = {
        let coverImage = UIImageView()
        coverImage.contentMode = .scaleAspectFit
        return coverImage
    }()
    lazy var nameLabel = UILabel()

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
        setupViewsConstraints()
    }
    
    func setupViewsConstraints() {
        coverImage.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.leading.equalTo(self.contentView).offset(10)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(coverImage.snp.trailing).offset(8)
            make.top.trailing.bottom.equalTo(self.contentView)
        }
        
        coverImage.setContentHuggingPriority(1000, for: .horizontal)
        nameLabel.setContentHuggingPriority(0, for: .horizontal)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
