//
//  forgetPasswordViewController.swift
//  好书
//
//  Created by 郭冬青 on 16/4/9.
//  Copyright © 2016年 郭冬青. All rights reserved.
//

import UIKit
import LeanCloud
import SnapKit

class forgetPasswordViewController: UIViewController {

  
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
    
    lazy var accountInputView: ETInputView = {
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_account"), placeholder: "请输入用户名")
        return inputView
    }()
    
    lazy var numberInputView: ETInputView = {
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_email"), placeholder: "请输入邮箱地址")
        inputView.textField.isSecureTextEntry = true
        return inputView
    }()
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitle("验证邮箱", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(forgetPasswordViewController.verifyAccount(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(RegisterViewController.close(sender:)), for: .touchUpInside)
        return button
    }()
    var logoHeightConstraint: Constraint!
    
    override func viewDidLoad() {
        setupInterface()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ETSignInViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ETSignInViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Interface
    func setupInterface() {
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(accountInputView)
        self.view.addSubview(numberInputView)
        self.view.addSubview(signInButton)
        self.view.addSubview(closeButton)
        
        
        setupViewsConstraints()
    }
    
    func setupViewsConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.centerX.equalTo(self.view)
            logoHeightConstraint = make.height.width.equalTo(100).constraint
        }
        
        accountInputView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalTo(260)
            make.centerX.equalTo(self.view)
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        numberInputView.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(accountInputView)
            make.top.equalTo(accountInputView.snp.bottom).offset(2)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(numberInputView)
            make.top.equalTo(numberInputView.snp.bottom).offset(30)
        }
        closeButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(signInButton)
            make.top.equalTo(signInButton.snp.bottom).offset(10)
        }
        
    }
    
    func verifyAccount(sender:UIButton) {
        
        let alert1 = UIAlertController(title: "提示", message: "请先填写邮箱地址", preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            
        }))
        
        if self.numberInputView.textField.text != "" {
            LCUser.requestPasswordReset(email: self.numberInputView.textField.text!) { (result) in
                if result.isSuccess{
                    ProgressHUD.showSuccess("已发送，请验证邮箱")
                    self.dismiss(animated: true, completion: {
                        
                    })
                }else {
                    //不同的错误码对应不同的错误提示
                    if result.error?.code == 125 {
                        ProgressHUD.showError("邮箱不合法")
                    }else if result.error?.code == 205 {
                        ProgressHUD.showError("此邮箱并未注册过")
                    }else {
                        ProgressHUD.showError("注册失败")
                    }
                }
            }
        }else {
            present(alert1, animated: true, completion: { 
                
            })
        }
        
    }
    func close(sender:UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        logoHeightConstraint.update(offset: 0)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        logoHeightConstraint.update(offset: 100)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    

}
