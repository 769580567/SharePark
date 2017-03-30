//
//  informationViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //界面控件的初始化
    lazy var coverImage:UIImageView = {
        let coverImage = UIImageView()
        coverImage.layer.cornerRadius = 25
        coverImage.layer.masksToBounds = true
        coverImage.image = UIImage(named: "Avatar")
        return coverImage
    }()
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    let dataAttay = ["我的名字:","我的车位:","我的余额:","我的电话:","我的邮箱:","修改密码:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "用户信息"
        self.view.backgroundColor = UIColor(red: 242/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        let leftitem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(InformationViewController.back(sender:)))
        leftitem.image = UIImage(named:"icon_back")
        self.navigationItem.leftBarButtonItem = leftitem
        
        setupInterface()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //配置tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? detailTableView_Cell
        cell?.firstLabel.text = dataAttay[indexPath.row]
        cell?.secondLabel.text = "内容"
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            
        }else {
            let vc = ChangeInformationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    //界面控件布局设置
    func setupInterface() {
        self.view.addSubview(coverImage)
        self.view.addSubview(tableView)
        
        setupViewsConstraints()
    }
    func setupViewsConstraints() {
        coverImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(85)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(SCREEN_WIDTH/2 - 16)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(coverImage.snp.bottom).offset(15)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.bottom.equalTo(self.view).offset(-15)
        }
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(detailTableView_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
    }
    func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    

    
}
