//
//  feedbackViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import SnapKit


class FeedbackViewController: UIViewController {

    var textView:JVFloatLabeledTextView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        initView()

        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "问题反馈"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"icon_back"), style: .plain, target: self, action: #selector(FeedbackViewController.back(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }

    func initView() {
        textView = JVFloatLabeledTextView()
        self.view.addSubview(textView!)
        textView?.placeholder = "    您可以在这里撰写您对本产品的评价、吐槽、建议等，我们衷心欢迎~~"
        textView?.font = UIFont.systemFont(ofSize: 20)
        textView?.tintColor = UIColor.gray
        textView?.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
        
        textView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(64)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.52)
        })
        
        
    }
    
    func sure(sender:UIBarButtonItem)  {

        let alert = UIAlertController(title: "提示", message: "我们已经接受到您的意见反馈，感谢您的参与!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            //self.navigationItem.backBarButtonItem?.action = #selector(self.back(sender:))
            self.navigationController?.popViewController(animated: true)
        }))

        present(alert, animated: true, completion: nil)
    }

    func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
