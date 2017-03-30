//
//  AllCheckViewController.swift
//  IPMS
//
//  Created by 🐑🐑🐑 on 16/12/14.
//  Copyright © 2016年 com.Chenziyang. All rights reserved.
//

import UIKit

class AllCheckViewController: UIViewController {

    let dbOperationManager = DbOperationManager.shareInstance
    
    var records = [Records]()
    
    @IBOutlet weak var recordTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordTableView.delegate = self
        recordTableView.dataSource = self
        
        records = dbOperationManager.getAllRecord()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension AllCheckViewController:UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordTableViewCell
        Cell.carNumber.text = records[indexPath.row].carNumber
        Cell.parkingSpace.text = "\(records[indexPath.row].parkingSpace)"
        Cell.timeIn.text = records[indexPath.row].timeIn
        Cell.timeOut.text = records[indexPath.row].timeOut
        if(records[indexPath.row].time == "") {
            Cell.time.text = ""
        } else{
        Cell.time.text = records[indexPath.row].time + "小时"
        }

        Cell.money.text = "\(records[indexPath.row].money)" + "元"
        
        return Cell
    }
}

extension AllCheckViewController:UITableViewDataSource {
    
}
