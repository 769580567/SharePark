//
//  MainViewController.swift
//  IPMS
//
//  Created by 🐑🐑🐑 on 16/12/14.
//  Copyright © 2016年 com.Chenziyang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var MainTableView: UITableView!
    
    let dbOperationManager = DbOperationManager.shareInstance
    
    
    var info = [(name:"进入停车场",image:"enter.png"),(name:"离开停车场",image:"leave.png"),(name:"查询空位",image:"check.png"),(name:"查询停车记录",image:"checkAll.png")]
    
    func messageAlert(message:String) {
        let alert = UIAlertController(title: message, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(alertAction)
        present(alert,animated: true,completion: nil)
    }

    //车辆进入
    
    func carEnter() {
        let alert = UIAlertController(title: "汽车进入停车场", message: "请输入车牌号", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textFile:UITextField) in
            //textFile.delegate = self
            textFile.placeholder = "车牌号"
        }
        
        let confirmAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default) {(action:UIAlertAction) in
            let textField = alert.textFields?.first!
          //  let carNumber = String(textField!.text)
            if (self.dbOperationManager.carEnter(card_number: (textField?.text)!)) {
                self.messageAlert(message: "没有车位")
            } else {
                self.messageAlert(message: "停车成功")
            }
    }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true,completion: nil)
    }
    
    
//车辆离开停车场
    func carLeave() {
        let alert = UIAlertController(title: "汽车离开停车场", message: "请输入车牌号", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textFile:UITextField) in
            //textFile.delegate = self
            textFile.placeholder = "车牌号"
        }
        
        let confirmAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default) {(action:UIAlertAction) in
            let textField = alert.textFields?.first!
            let a = self.dbOperationManager.carLeave(car_number: (textField?.text)!)
            if (!a.0) {
                self.messageAlert(message: "没有本辆车")
            } else {
                self.messageAlert(message: "取车成功，需交费 \(a.1)元")
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true,completion: nil)
    }
    
    func freeOrNot() {
        if (self.dbOperationManager.freeOrNot()) {
            messageAlert(message: "没有车位")
        } else {
            messageAlert(message: "欢迎停车，还有车位")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        MainTableView.delegate = self
        MainTableView.dataSource = self
       
        self.dbOperationManager.getAllRecord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension MainViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        
        Cell.CellLabel.text = info[indexPath.item].name
        Cell.CellImage.image = UIImage(named:info[indexPath.item].image)
        return Cell
    }
}


extension MainViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
           // performSegue(withIdentifier: "showEnterViewController", sender: self)
            carEnter()
        case 1:
            carLeave()
        case 2:
            freeOrNot()
        case 3:
            performSegue(withIdentifier: "showAllCheckViewController", sender: self)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
