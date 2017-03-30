//
//  aboutUsViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import SnapKit

class AboutUsViewController: UIViewController, UIGestureRecognizerDelegate {

    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_background")
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon_app_logo")
        imageView.layer.cornerRadius = 20.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var aboutText:UITextView = {
        let aboutText = UITextView()
        aboutText.text = "<共享停车场>\n   我们致力于盘活整合车位资源，在<共享停车场>平台上,业主可将闲置车位放租，车主可以选择合适车位租用，物业将车位信息透明化，公开化，给车主，业主，物业创造三惠三赢得机会，打造车场行业的Airbnb传奇。\n   为用户创造价值：\n   盘活车位分享创造收益，快捷方便节省停车费用。\n   为物业创造价值：\n   利用科技节省人力成本，联动服务提高物业收益。"
        aboutText.backgroundColor = UIColor.clear
        aboutText.textColor = UIColor.white
        aboutText.font = UIFont.systemFont(ofSize: 17)
        aboutText.isEditable = false
        return aboutText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.tabBarController?.tabBar.isHidden = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupInterface() {
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(aboutText)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.centerX.equalTo(self.view)
        }
        
        aboutText.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(35)
            make.leading.equalTo(self.view).offset(35)
            make.trailing.equalTo(self.view).offset(-35)
            make.bottom.equalTo(self.view).offset(20)
        }
    }


}
