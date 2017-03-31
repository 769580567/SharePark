//
//  LeaseViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import SnapKit
import AVOSCloud

class LeaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
    lazy var tableView = UITableView()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.brown.withAlphaComponent(0.7), NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
         self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named:"icon_fresh"), style: .plain, target: self, action: #selector(LeaseViewController.fresh(sender:)))
        
        self.view.backgroundColor = UIColor(red: 248/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        self.tableView.separatorStyle = .none

        setupInterface()
            
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.freshAction()

    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            
    }
//cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
//cell设置
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaseView_Cell
        
        
        cell?.backgroundColor = UIColor(red: 255/255, green: 248/255, blue: 248/255, alpha: 1.0)
        cell?.coverImage.image = UIImage(named:"Avatar")
        cell?.nameLabel.text = "名字"
        cell?.numberLabel.text = "车位号码为：123"
        cell?.costLabel.text = "费用为：15元/小时"
        cell?.timeLabel.text = "停车时间：08：00-16：00"
        
        return cell!
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//自定义cell的action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let leaseAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "租用") { (action, indexPath) in

            let alert = UIAlertController(title: "提示", message: "租用本车位成功", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)

        }
        leaseAction.backgroundColor = UIColor(red: 28/255, green: 165/255, blue: 253/255, alpha: 0.5)
        return [leaseAction]
    }
//cell的点击界面跳转
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = detailViewController()
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //刷新按钮
    func fresh(sender:UIBarButtonItem)  {
        
//        let query = AVQuery(className: "records")
//        query.order(byDescending: "createdAt")
        
    }
    
    
//界面控件布局设置
    func setupInterface() {
            
        self.view.addSubview(tableView)
            
        initMoreView()
    }
    func initMoreView(){
       
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
                
        }
        self.tableView.backgroundColor = UIColor(red: 248/255, green: 255/255, blue: 255/255, alpha: 1.0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(LeaseView_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
    }
    //刷新动画效果
    func freshAction() {
        let diff = 0.1
        let tabelHight = self.tableView.bounds.size.height
        let cells:[LeaseView_Cell] = self.tableView.visibleCells as! [LeaseView_Cell]
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0,y: tabelHight)
        }
        for i in 0..<cells.count {
            let cell:LeaseView_Cell = cells[i] as LeaseView_Cell
            let delay = diff * Double(i)
            UIView.animate(withDuration: 0.5, delay: delay, options: UIViewAnimationOptions.allowAnimatedContent, animations: { 
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    


}
