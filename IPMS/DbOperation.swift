//
//  DbOperation.swift
//  IPMS
//
//  Created by 🐑🐑🐑 on 16/12/14.
//  Copyright © 2016年 com.Chenziyang. All rights reserved.
//

import Foundation
import FMDB

class DbOperationManager {
    static let shareInstance = DbOperationManager()
    
    var database:FMDatabase!
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(time:String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: time)!
    }
    


    
    fileprivate init() {

        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("IPMS.sqlite")
        print(fileURL)
        
        database = FMDatabase(path:fileURL.path)
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        
        createTables()
    }

    
    fileprivate func createTables() {
        do {
            try database.executeUpdate("create table if not exists parking_space(id integer primary key autoincrement,car_number text default '' ,free boolean default false ,time text default '')", values: nil)
            
            try database.executeUpdate("create table if not exists record(car_number text,parking_space integert not null,time_in text default '' ,time_out text default '' ,time text default '' ,money double default 0.0)", values: nil)
            for _ in 0 ..< 5  {
            
                try database.executeUpdate("insert into parking_space (time,free) values(?,?)",values: ["0",false])
            }

        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
//车辆进入停车场
    func carEnter(card_number:String) -> Bool {
        var id:Int32 = 0
        do {
            
            let result = try database.executeQuery("select id from parking_space where free = 0  order by RANDOM() limit 1", values: nil)
            
            while result.next() {
                 id = result.int(forColumn: "id")
            }
            print(id)

            if (id != 0) {
                
                try database.executeUpdate("update parking_space set car_number = ?  where id = ?", values: [card_number,id])
                try database.executeUpdate("update parking_space set free = ?  where id = ?", values: [1,id])
                
                try database.executeUpdate("update parking_space set time = ?  where id = ?", values: [getCurrentDate(),id])
                
                try database.executeUpdate("insert into record (car_number,parking_space,time_in,money) values(?,?,?,?)", values: [card_number,id,getCurrentDate(),0])
                return false
            } else {
                return true
            }

        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return true
    }
    
//车辆离开停车场
    func carLeave(car_number:String) -> (Bool,Int) {
        var id:Int32 = 0
        var time_in = ""
        var a:Date = Date()
        do {
           let result = try database.executeQuery("select id from parking_space where car_number = ?", values: [car_number])
            
            while result.next() {
                 id = result.int(forColumn: "id")
            }
            print(id)
            
            if (id != 0) {
                try database.executeUpdate("update parking_space set car_number = ?  where id = ?", values: [0,id])
                try database.executeUpdate("update parking_space set free = ?  where id = ?", values: [0,id])
                
                try database.executeUpdate("update parking_space set time = ?  where id = ?", values: [0,id])
                
                try database.executeUpdate("update record set time_out = ? where car_number = ?", values: [getCurrentDate(),car_number])
                
            let result2 = try database.executeQuery("select time_in from record where car_number = ?", values: [car_number])
                
                while result2.next() {
                    time_in = result2.string(forColumn: "time_in")
                  //  print(time_in)
                    
                  a =    stringToDate(time: time_in)
                //print(Date().timeIntervalSince(a))

                    
                   // print(ceil(Date().timeIntervalSince(a) / 3600))
                    print(a)
                }
                
                try database.executeUpdate("update record set time = ? where car_number = ?", values: [ceil(Date().timeIntervalSince(a) / 3600),car_number])
                
                try database.executeUpdate("update record set money = ? where car_number = ?", values: [ceil(Date().timeIntervalSince(a) / 3600) * 5,car_number])
                print((Date().timeIntervalSince(a) / 3600) * 5)
                return (true,Int(ceil(Date().timeIntervalSince(a) / 3600)) * 5)
            } else {
                return (false,Int(ceil(Date().timeIntervalSince(a) / 3600)) * 5)
            }
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return (true,0)
    }
//判断是否有空的车位
    
    func freeOrNot() -> Bool {
        var id:Int32 = 0
 
        do {
            let result = try database.executeQuery("select id from parking_space where free = 0  order by RANDOM() limit 1", values: nil)
            
            while result.next() {
                id = result.int(forColumn: "id")
            }
            print(id)
            if (id == 0) {
                return true
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return false
    }
    
    
//获取所有停车记录
    func getAllRecord() -> [Records] {
        var records = [Records]()
        
        do {
            let results = try database.executeQuery("select * from record", values: nil)
            
            while results.next() {
                let record = Records()
                record.carNumber = results.string(forColumn: "car_number")
                record.parkingSpace = Int(results.int(forColumn: "parking_space"))
                record.timeIn = results.string(forColumn: "time_in")
                record.timeOut = results.string(forColumn: "time_out")
                record.time = results.string(forColumn: "time")
                record.money = results.double(forColumn: "money")
                
                records.append(record)
                print(record.carNumber)
                print(records)
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return records
    }
}
