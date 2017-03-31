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
        
        let user = AVUser.current()
        //let imageUrl = user?["avatarImage"] as! String
        
        let cover = dict["userCover"] as? UIImage
        let scaledImg = UIImage(data: UIImagePNGRepresentation(cover!)!)
        let coverFile = AVFile(data:UIImagePNGRepresentation(scaledImg!)!)
        coverFile.saveInBackground { (success, error) in
            if success{
                user?.setObject(coverFile.url, forKey: "avatarImage")
                user?.save()
            }else {
                UpDataFailed()
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
        //类型，0为没有，1为出租中，2为租用中
        carRecord.setObject(dict["type"], forKey: "type")
        carRecord.setObject(dict["beginDate"], forKey: "beginDate")
        carRecord.setObject(dict["endDate"], forKey: "endDate")
        
        carRecord.setObject(AVUser.current(), forKey: "user")
        
        carRecord.saveInBackground { (success, error) in
            if success{
                
            }else {
                UpDataFailed()
            }
        }
    }
    
    static func UpDataFailed(){
        let alert = UIAlertController(title: "提示", message: "上传数据失败", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            
        }))
    }
}
