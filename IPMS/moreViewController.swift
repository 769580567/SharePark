//
//  moreViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import AVOSCloud
import SDWebImage

class moreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    lazy var tableView = UITableView()
    lazy var backgroundImage = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var coverImage:UIImageView = {
        let coverImage = UIImageView()
        
        return coverImage
    }()

//cell数组数据
    var nameArray:[[DataArray]] =
    [[DataArray(contentLabel:"个人资料",coverName:"icon_personalData")],
    [DataArray(contentLabel:"我的记录",coverName:"icon_record")],
    [DataArray(contentLabel:"意见反馈",coverName:"icon_feedback"),DataArray(contentLabel:"关于《共享停车场》",coverName:"icon_aboutUs")],
    [DataArray(contentLabel:"退出登录",coverName:"")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 206/255, green: 189/255, blue: 176/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.brown.withAlphaComponent(0.7)

        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.brown.withAlphaComponent(0.7), NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
        
        self.setupInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
 //section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 2
        }else if section == 0 || section == 1 ||  section == 3{
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
//cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? moreView_Cell
        cell?.nameLabel.text = nameArray[indexPath.section][indexPath.row].contentLabel
        cell?.nameLabel.text = nameArray[indexPath.section][indexPath.row].contentLabel
        if indexPath.section != 3 {
            cell?.coverImage.image = UIImage(named: nameArray[indexPath.section][indexPath.row].coverName)
        }

        cell?.accessoryType = .disclosureIndicator
        
        if indexPath.section == 3 {
            cell?.nameLabel.textColor = UIColor.red
            cell?.nameLabel.textAlignment = .center
            cell?.nameLabel.font = UIFont.systemFont(ofSize: 20)
            
            cell?.accessoryType = .none
            
            cell?.coverImage.snp.remakeConstraints({ (make) in
                make.leading.top.bottom.equalTo(cell!.contentView)
                make.width.equalTo(0)
            })
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "

    }
//section height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 0
        }
        return 30
    }

//cell的界面跳转
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc: UIViewController!
        
        switch indexPath.section {
        case 0:
            //个人资料界面
            vc = InformationViewController()
            break
        case 1:
            //停车记录界面
            vc = RecordViewController()
            break
        case 2:
            if indexPath.row == 0{
                //意见反馈界面
                vc = FeedbackViewController()
            }else if indexPath.row == 1{
                //关于《共享停车场》
                vc = AboutUsViewController()
            }
            break
        case 3:
            self.tabBarController?.tabBar.isHidden = true
            AVUser.logOut()
            let story = UIStoryboard(name: "Login", bundle: nil)
            vc = story.instantiateViewController(withIdentifier: "Login")
            break
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
//界面控件布局设置
    func setupInterface() {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(coverImage)
        self.view.addSubview(nameLabel)
        self.view.addSubview(tableView)
        
        initMoreView()
    }
    func initMoreView(){
        backgroundImage.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.view).offset(5)
            make.height.equalTo(SCREEN_HEIGHT/3 - 20)
        }

        coverImage.image = UIImage(named: "Avatar")
        coverImage.layer.cornerRadius = 50
        coverImage.layer.masksToBounds = true
        coverImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(25)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(SCREEN_HEIGHT/3 - 70)
        }
        
        nameLabel.text = "你的名字"
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImage.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(backgroundImage.snp.bottom).offset(10)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(moreView_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
