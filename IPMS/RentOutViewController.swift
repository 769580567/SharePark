//
//  RentOutViewController.swift
//  IPMS
//
//  Created by air on 2017/3/28.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import SnapKit
import AVOSCloud

class RentOutViewController: UIViewController {

    var logoHeightConstraint: Constraint!
    var selectedButton:UIButton!
//创建界面控件
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image_background")
        imageView.alpha = 0.7
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
    lazy var beginTimeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 200.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        button.setTitle("选择开始时间", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.brown, for: .normal)
        button.addTarget(self, action: #selector(RentOutViewController.chooseTimeAction(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var endTimeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 200.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        button.setTitle("选择结束时间", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.brown, for: .normal)
        button.addTarget(self, action: #selector(RentOutViewController.chooseTimeAction(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 255/255, alpha: 1)
        button.setTitle("确定", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.brown, for: .normal)
        button.addTarget(self, action: #selector(RentOutViewController.confirmAction(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = UIColor(red: 206/255, green: 189/255, blue: 176/255, alpha: 1)
        picker.tintColor = UIColor.blue
        picker.datePickerMode = .time
        return picker
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(self.timePicker)
        view.addSubview(self.confirmButton)
        return view
    }()
    lazy var costInputView: ETInputView = {
        let inputView = ETInputView.createInputView(icon: UIImage(named: "icon_money"), placeholder: "请输入租用时薪")
        inputView.layer.cornerRadius = 20
        inputView.imageView.layer.cornerRadius = 20
        return inputView
    }()
    lazy var RentOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 226/255, green: 188/255, blue: 123/255, alpha: 1)
        button.setTitle("发布车位", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 60
        button.addTarget(self, action: #selector(RentOutViewController.rentOut(sender:)), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupInterface()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RentOutViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RentOutViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
//界面控件布局
    func setupInterface() {
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(beginTimeButton)
        self.view.addSubview(endTimeButton)
        self.view.addSubview(timePicker)
        self.view.addSubview(containerView)
        self.view.addSubview(costInputView)
        self.view.addSubview(RentOutButton)
        
        setupViewsConstraint()
        }
    func setupViewsConstraint() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.centerX.equalTo(self.view)
            logoHeightConstraint = make.height.width.equalTo(100).constraint
        }
        beginTimeButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(240)
            make.height.equalTo(45)
        }
        endTimeButton.snp.makeConstraints { (make) in
            make.top.equalTo(beginTimeButton.snp.bottom).offset(12)
            make.leading.trailing.height.equalTo(beginTimeButton)
        }

        costInputView.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(endTimeButton)
            make.top.equalTo(endTimeButton.snp.bottom).offset(12)
        }
        RentOutButton.snp.makeConstraints { (make) in
            
            make.width.height.equalTo(120)
            make.centerX.equalTo(self.view)
            make.top.equalTo(costInputView.snp.bottom).offset(30)
        }
        containerView.snp.makeConstraints { (make) in
            make.left.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(200)
        }
        timePicker.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        confirmButton.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(timePicker.snp.bottom)
        }
    }
    //发布共享车位按钮事件
    func rentOut(sender:UIButton) {
        
//        let time = timeInputView.textField.text
        let cost = costInputView.textField.text
        
//        if time != "" && cost != "" {
//            
//        }else {
//            let alert1 = UIAlertController(title: "提示", message: "请完善信息", preferredStyle: .alert)
//            alert1.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
//                
//            }))
//            
//            present(alert1, animated: true, completion: {
//                
//            })
//        }
        
    }
    
    
    
    func chooseTimeAction(sender: UIButton) {
        selectedButton = sender
        
        containerView.snp.remakeConstraints { (make) in
            make.left.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(-49)
        }
        logoHeightConstraint.update(offset: 0)
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    func formateTime() -> String {
        let date = timePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: date)
        return timeString
    }
    func hideTimePicker() {
        containerView.snp.remakeConstraints { (make) in
            make.left.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(200)
        }
        logoHeightConstraint.update(offset: 100)
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    func confirmAction(sender: UIButton) {
        hideTimePicker()
        selectedButton.setTitle(formateTime(), for: .normal)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        hideTimePicker()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func keyboardWillShow(notification: Notification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        hideTimePicker()
        
        logoHeightConstraint.update(offset: 0)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        hideTimePicker()
        logoHeightConstraint.update(offset: 100)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    

}
