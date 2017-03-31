//
//  ChangeInformationViewController.swift
//  IPMS
//
//  Created by air on 2017/3/28.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import SnapKit
import AVOSCloud

class ChangeInformationViewController: UIViewController {

    lazy var changeTextField: UITextField = {
        let changeTextField = UITextField()
        changeTextField.placeholder = "请输入新的信息"
        changeTextField.backgroundColor = UIColor.white
        changeTextField.font = UIFont.systemFont(ofSize: 20)
        changeTextField.borderStyle = UITextBorderStyle.roundedRect
        changeTextField.layer.borderWidth = 1.0
        changeTextField.layer.cornerRadius = 10
        changeTextField.clearButtonMode = UITextFieldViewMode.always
        return changeTextField
    }()
    
//    lazy var passwordText:UITextField = {
//       let passwordText = UITextField()
//        passwordText.placeholder = "请输入密码"
//        passwordText.backgroundColor = UIColor.white
//        passwordText.font = UIFont.systemFont(ofSize: 20)
//        passwordText.layer.borderWidth = 1.0
//        passwordText.borderStyle = UITextBorderStyle.roundedRect
//        passwordText.layer.cornerRadius = 10
//        passwordText.clearButtonMode = UITextFieldViewMode.always
//        passwordText.isSecureTextEntry = true
//        return passwordText
//    }()
//    
    
    var indexPath = Int()
    lazy var user:AVUser = {
        let user = AVUser.current()
        return user!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
        
        self.view.backgroundColor = UIColor(red: 242/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"icon_back"), style: .plain, target: self, action: #selector(ChangeInformationViewController.back(sender:)))
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named:"icon_save"), style: .plain, target: self, action: #selector(ChangeInformationViewController.save(sender:)))
        


        NotificationCenter.default.addObserver(self, selector: #selector(ChangeInformationViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChangeInformationViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func setupInterface(){
        self.view.addSubview(changeTextField)
//        self.view.addSubview(passwordText)
        
        changeTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view).offset(10)
            make.trailing.equalTo(self.view).offset(-10)
            make.top.equalTo(self.view).offset(78)
            make.height.equalTo(45)
        }
//        passwordText.snp.makeConstraints { (make) in
//            make.leading.trailing.height.equalTo(changeTextField)
//            make.top.equalTo(changeTextField.snp.bottom).offset(5)
//        }
      
    }
    func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    func save(sender:UIBarButtonItem){
        if indexPath == 0{
            user.username = changeTextField.text
            
        }else if indexPath == 1 {
            user["carNumber"] = Int(changeTextField.text!)
        }else if indexPath == 3 {
            user.mobilePhoneNumber = changeTextField.text
        }else if indexPath == 4 {
            user.email = changeTextField.text
        }
        user.saveInBackground({ (success, error) in
            if success {
                self.addSuccessAlertView()
            }else{
                self.addFailedAlertView()
            }
        })
        
    }
    
    func addSuccessAlertView() {
        let alert = UIAlertController(title: "提示", message: "修改成功", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (cation) in
            let _ = self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func addFailedAlertView() {
        let alert = UIAlertController(title: "提示", message: "修改失败", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (cation) in
             let _ = self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
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
        //logoHeightConstraint.update(offset: 0)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        //logoHeightConstraint.update(offset: 100)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
}
