//
//  dataTable.swift
//  IPMS
//
//  Created by air on 2017/3/29.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import AVOSCloud

class DataTable:NSObject {

    static func pushRecordInBack(_ dict:NSDictionary){
        
        
        let carRecord = AVObject(className:"records")
        carRecord.setObject(dict["carNumber"], forKey: "carNumber")
        //时薪
        carRecord.setObject(dict["wage"], forKey: "wage")
        //总消费
        carRecord.setObject(dict["cost"], forKey: "cost")
        //类型，0为没有，1为出租中，2为租用中
        carRecord.setObject(dict["type"], forKey: "type")
        carRecord.setObject(dict["beginDate"], forKey: "beginDate")
        carRecord.setObject(dict["endDate"], forKey: "endDate")
        
        carRecord.setObject(AVUser.current()?.objectId, forKey: "userID")
        
        carRecord.saveInBackground { (success, error) in
            if success{
                AVUser.current()?.setObject(1, forKey: "type")
                AVUser.current()?.save()
            }else {

            }
        }
    }

}
