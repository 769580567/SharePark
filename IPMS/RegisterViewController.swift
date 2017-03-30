//
//  RegisterViewController.swift
//  IPMS
//
//  Created by 郭冬青 on 2017/3/9.


import UIKit
import LeanCloud
import SnapKit

class RegisterViewController: UIViewController {
    
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
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_phone"), placeholder: "请输入手机号码")
        return inputView
    }()
    
    lazy var emailInputView: ETInputView = {
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_email"), placeholder: "请输入邮箱")
        return inputView
    }()
    
    lazy var passwordInputView: ETInputView = {
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_password"), placeholder: "请输入密码")
        inputView.textField.isSecureTextEntry = true
        return inputView
    }()
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(RegisterViewController.GetNewAccount(sender:)), for: .touchUpInside)
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
        self.view.addSubview(emailInputView)
        self.view.addSubview(passwordInputView)
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
        
        emailInputView.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(numberInputView)
            make.top.equalTo(numberInputView.snp.bottom).offset(2)
        }
        
        passwordInputView.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(emailInputView)
            make.top.equalTo(emailInputView.snp.bottom).offset(2)
        }
        signInButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(passwordInputView)
            make.top.equalTo(passwordInputView.snp.bottom).offset(30)
        }
        closeButton.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(signInButton)
            make.top.equalTo(signInButton.snp.bottom).offset(10)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func GetNewAccount(sender: UIButton) {
        //debugLog()
        let user = LCUser()
        let userName = self.accountInputView.textField.text
        let phone = self.numberInputView.textField.text
        let password = self.passwordInputView.textField.text
        let email = self.emailInputView.textField.text
        user.username = LCString(userName!)
        user.mobilePhoneNumber = LCString(phone!)
        user.password = LCString(password!)
        user.email = LCString(email!)
        
        let alert1 = UIAlertController(title: "提示", message: "请先完善信息", preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            
        }))
        
        let alert = UIAlertController(title: "验证手机号码", message: "请输入手机验证码", preferredStyle: .alert)
        alert.addTextField { (verifyText) in
            verifyText.placeholder = "手机验证码"
        }
        
        if userName != "" && password != "" && phone != "" && email != "" {
            //发送验证码
            LCSMS.requestVerificationCode(mobilePhoneNumber: self.numberInputView.textField.text!, completion: { (request) in
                
                if request.isSuccess{
                    
                }})
            
            present(alert, animated: true) {
            }

        }else{
            present(alert1, animated: true, completion: { 
                
            })
        }
       
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            let textfield = alert.textFields?.first

                    //检验验证码
                    LCSMS.verifyMobilePhoneNumber(self.numberInputView.textField.text!, verificationCode: (textfield?.text!)!, completion: { (verify) in
                        if verify.isSuccess{
                            //注册用户
                            user.signUp { (result) in
                                if result.isSuccess{
                                    ProgressHUD.showSuccess("注册成功")
                                }else {
                                    if result.error?.code == 125 {
                                        ProgressHUD.showError("该邮箱不合法")
                                    }
                                    if result.error?.code == 202 {
                                        ProgressHUD.showError("用户名已存在")
                                    }else {
                                        ProgressHUD.showError("该号码不合法或者已注册过")
                                    }
                                }
                            }
                            self.dismiss(animated: true, completion: {
                            })
                        }else if verify.isFailure{
                            ProgressHUD.showError("验证码错误")
                        }else {
                            ProgressHUD.showError("系统繁忙，请稍后重试")
                        }
                    })
            }))
        
        
        
    }

    func close(sender:UIButton) {
        self.dismiss(animated: true) { 
            
        }
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

