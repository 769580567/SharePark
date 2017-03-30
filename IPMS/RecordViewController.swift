//
//  recordViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "我的记录"
        setupInterface()
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 245/255, blue: 245/255, alpha: 1.0)
        self.automaticallyAdjustsScrollViewInsets = false
        //增添导航页按钮
//        let leftitem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(RecordViewController.back(sender:)))
//        leftitem.image = UIImage(named:"icon_back")
//        self.navigationItem.leftBarButtonItem = leftitem
//        let rightitem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(RecordViewController.clearAllRecord(sender:)))
//        rightitem.image = UIImage(named:"icon_clean")
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named:"icon_clean"), style: .plain, target: self, action: #selector(RecordViewController.clearAllRecord(sender:)))
//        self.navigationItem.rightBarButtonItem = rightitem
        
        //取消cell的线
        self.tableView.separatorStyle = .none
        
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? recordView_Cell

        cell?.backgroundColor = UIColor(red: 255/255, green: 245/255, blue: 245/255, alpha: 0.5)
        cell?.coverImage.image = UIImage(named:"Avatar")
        cell?.typeLabel.text = "类型：租用"
        cell?.numberLabel.text = "车位号码为：123"
        cell?.costLabel.text = "费用为：100"
        cell?.timeLabel.text = "停车时间：08：00-16：00"
        
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func setupInterface() {

        self.view.addSubview(tableView)
        
        initMoreView()
    }
    func initMoreView(){

        
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)

        }
        self.tableView.backgroundColor = UIColor(red: 242/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(recordView_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
    }

    func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
//清除所有记录
    func clearAllRecord(sender:UIBarButtonItem){
        let alert = UIAlertController(title: "提示", message: "确定要清空所有记录吗", preferredStyle: .actionSheet)
        alert.automaticallyAdjustsScrollViewInsets = true
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
