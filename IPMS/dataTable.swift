//
//  dataTable.swift
//  IPMS
//
//  Created by air on 2017/3/29.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import AVOSCloud

class dataTable:NSObject {
    static func pushUserInBack(_ dict:NSDictionary,object:AVObject){
        
        let object = AVObject(className:"Account")
        object.setObject(dict["phoneNumber"], forKey: "phoneNumber")
        object.setObject(dict["email"], forKey: "email")
        object.setObject(dict["balance"], forKey: "balance")
        object.setObject(dict["carNumber"], forKey: "carNumber")
        
        AVUser.current()
        object.setObject(AVUser.current(), forKey: "user")
        
        
        let cover = dict["userCover"] as? UIImage
        let scaledImg = UIImage(data: UIImagePNGRepresentation(cover!)!)
        let coverFile = AVFile(data:UIImagePNGRepresentation(scaledImg!)!)
        coverFile.saveInBackground { (success, error) in
            if success{
                object.setObject(coverFile, forKey: "cvoer")
                object.saveEventually({ (success, error) -> Void in
                    if success {
                        /**
                         *  调用通知
                         */
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"true"])
                    }else{
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"false"])
                    }
                })
            }else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "pushCallBack"), object: nil, userInfo: ["success":"false"])
            }
        }
    }
    static func pushRecordInBack(_ dict:NSDictionary,carRecord:AVObject){
        
        
        let carRecord = AVObject(className:"records")
        carRecord.setObject(dict["carNumber"], forKey: "carNumber")
        //时薪
        carRecord.setObject(dict["wage"], forKey: "wage")
        //总消费
        carRecord.setObject(dict["cost"], forKey: "cost")
        carRecord.setObject(dict["beginDate"], forKey: "beginDate")
        carRecord.setObject(dict["endDate"], forKey: "endDate")
        
        
        
        carRecord.setObject(AVUser.current(), forKey: "user")
    }
}
