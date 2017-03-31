//
//  ViewController.swift
//  DengLuYi
//
//  Created by Egetart on 2017/3/13.
//  Copyright © 2017年 Egetart. All rights reserved.
//

import UIKit
import SnapKit
import AVOSCloud

class ETSignInViewController: UIViewController {

// MARK: - Properties
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
    
    lazy var passwordInputView: ETInputView = {
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_password"), placeholder: "请输入密码")
        inputView.textField.isSecureTextEntry = true
        return inputView
    }()
    
    
    lazy var signUpPromptView: UIView = {
        let promptView = UIView()
        
        let label = UILabel()
        label.text = "首次使用?"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        
        let button = UIButton()
        button.setTitle("注册新账户", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(ETSignInViewController.signUpAction(sender:)), for: .touchUpInside)
        
        let button1 = UIButton()
        button1.setTitle("忘记密码?", for: .normal)
        button1.setTitleColor(UIColor.red, for: .normal)
        button1.setTitleColor(UIColor.lightText, for: .highlighted)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button1.addTarget(self, action: #selector(ETSignInViewController.forgetPassword(sender:)), for: .touchUpInside)
        
        promptView.addSubview(label)
        promptView.addSubview(button)
        promptView.addSubview(button1)
        
        label.snp.makeConstraints({ (make) in
            make.leading.top.bottom.equalTo(promptView)
        })
        
        button.snp.makeConstraints({ (make) in
            make.leading.equalTo(label.snp.trailing).offset(8)
            make.top.bottom.equalTo(promptView)
        })
        button1.snp.makeConstraints({ (make) in
            make.leading.equalTo(button.snp.trailing).offset(14)
            make.top.bottom.equalTo(promptView)
        })
        promptView.isUserInteractionEnabled = true
        return promptView
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(ETSignInViewController.signInAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    var logoHeightConstraint: Constraint!

// MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.view.addSubview(passwordInputView)
        self.view.addSubview(signUpPromptView)
        self.view.addSubview(signInButton)

        
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
        
        passwordInputView.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(accountInputView)
            make.top.equalTo(accountInputView.snp.bottom).offset(2)
        }
        
        
        signUpPromptView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(passwordInputView)
            make.top.equalTo(passwordInputView.snp.bottom).offset(8)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(passwordInputView)
            make.top.equalTo(signUpPromptView.snp.bottom).offset(30)
        }
    }
    
// MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func signUpAction(sender: UIButton) {
        //debugLog()
        let vc = storyboard?.instantiateViewController(withIdentifier: "Register")
        present(vc!, animated: true, completion: nil)
    }
    
    func signInAction(sender: UIButton) {
        //debugLog()
        
        AVUser.logInWithUsername(inBackground: self.accountInputView.textField.text!, password: self.passwordInputView.textField.text!) { (user, error) in
            
            if user != nil{
         
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "Main")
                
                self.present(vc, animated: true, completion: nil)
                
            }else{
//                if == 210{
//                }
                    ProgressHUD.showError("用户名或密码错误")
//                }else if error?.code == 211 {
//                    ProgressHUD.showError("不存在该用户")
//
//                }else if error?.code == 1{
//                    ProgressHUD.showError("操作频繁")
//                }else{
                    ProgressHUD.showError("登录失败")
//                }
            }
        }
    }
    
    func forgetPassword(sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPassword")
        present(vc!, animated: true, completion: nil)
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

