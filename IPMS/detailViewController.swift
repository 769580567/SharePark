//
//  detailViewController.swift
//  IPMS
//
//  Created by air on 2017/3/28.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit

class detailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var x = 0
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
    
    let dataAttay = ["用户名字:","用户车位:","联系电话:","租赁费用:","租赁时间:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户信息"
        self.view.backgroundColor = UIColor(red: 242/255, green: 255/255, blue: 255/255, alpha: 1.0)

        let leftitem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(detailViewController.back(sender:)))
        leftitem.image = UIImage(named:"icon_back")
        self.navigationItem.leftBarButtonItem = leftitem
        
        self.tableView.separatorStyle = .none
        
        setupInterface()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//配置tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? detailTableView_Cell
        
        cell?.isUserInteractionEnabled = false
        cell?.firstLabel.text = dataAttay[indexPath.row]
        cell?.secondLabel.text = "内容"
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    
    func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
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
            make.leading.bottom.equalTo(self.view).offset(15)
            make.trailing.equalTo(self.view).offset(-15)
        }
        
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(detailTableView_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()

    }
    

}
