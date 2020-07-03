//
//  ViewController.swift
//  calendarTest
//
//  Created by Dustin on 2019/9/16.
//  Copyright © 2019 Dustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let now = Date()
//        print("\(now)")
        
//        let timeInterval:TimeInterval = now.timeIntervalSince1970
//        let time:Int = Int(timeInterval)
        
//        print("現在時間的時間戳：\(time)")
//        print("轉換時間戳：\(setDataTrans(currentTime: time))")

        //創建一個DateFormatter來作為轉換的橋樑
//        let dateFormatter = DateFormatter()
        //設置時間格式（這裡的dateFormatter對象在上一段代碼中創建）
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //調用字符串方法進行轉換
//        let convertedDate0 = dateFormatter.string(from: now)
        //輸出轉換結果
//        print("\(convertedDate0)")//结果为：2018-01-11 11:45:30\n
        
        
        let dateComponents:DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
        
        let date:Date = dateComponents.date!.getTimeZoneDate()

//        print(date)
//        print(date.timeIntervalSince1970)
//        print(setDataTrans(currentTime: Int(date.timeIntervalSince1970)))
//
//        var dateCompon:DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
//        dateCompon.day = 28
//        let date1:Date = dateCompon.date!.getTimeZoneDate()
//
//        print(date1)
//        print(date1.timeIntervalSince1970)
//        print(setDataTrans(currentTime: Int(date1.timeIntervalSince1970)))

        //開始時間
        let week:Date = Date().startOfWeek
        let weeks = week.toDate(format: "yyyy-MM-dd")
        print("week \(weeks)")
        print(setDataTrans(currentTime: Int(week.timeIntervalSince1970)))

        //結束時間
        let week1:Date = Date().endOfWeek
        let week1s = week1.toDate(format: "yyyy-MM-dd")
        print("week1s \(week1s)")
        print(setDataTrans(currentTime: Int(week1.timeIntervalSince1970)))

        Date().getWeekDay(dateTime: week1s)
        print(Date().getWeekDay(dateTime: week1s))
        
        //抓每週時間
        let arrWeekDates = Date().getWeekDates()
        let dateFormat = "yyyy-MM-dd"
        
        let nextMon = arrWeekDates.thisWeek[arrWeekDates.thisWeek.count - 1].toDate(format: dateFormat)
        let nextMon2 = arrWeekDates.thisWeek[arrWeekDates.thisWeek.count - 1]

        let thirthMon = arrWeekDates.nextWeek[arrWeekDates.nextWeek.count - 1].toDate(format: dateFormat)
        let thirthMon1 = arrWeekDates.thirthWeek.first
        let thirthMon2 = arrWeekDates.nextWeek[arrWeekDates.nextWeek.count - 1]
        
        let fourMon = arrWeekDates.thirthWeek[arrWeekDates.thirthWeek.count - 1].toDate(format: dateFormat)
        let fiveMon = arrWeekDates.fourWeek[arrWeekDates.fourWeek.count - 1].toDate(format: dateFormat)
        let sixMon = arrWeekDates.fiveWeek[arrWeekDates.fiveWeek.count - 1].toDate(format: dateFormat)

        print("===========================")
        print("nextMon \(nextMon)")
        print("nextMon2 \(nextMon2)")
        print("===========================")
        print("thirthMon \(thirthMon)")
        print("thirthMon1 \(thirthMon1)")
        print("thirthMon2 \(thirthMon2)")

//        print(setDataTrans(currentTime: Int(nextMon2.timeIntervalSince1970)))
        
//        print(thirthMon)
//        print(fourMon)
//        print(fiveMon)
//        print(sixMon)
    }

    /**計算時間給server*/
    func setDataTrans(currentTime:Int) -> String{
        let t1:Int = currentTime * 10000000 + 621355968000000000
        let t1Str = String(t1)
        
        return t1Str
    }
    
}

extension Date {
    /**抓每週時間*/
    func getWeekDates() -> (thisWeek:[Date],nextWeek:[Date],thirthWeek:[Date],fourWeek:[Date],fiveWeek:[Date],sixWeek:[Date]) {
        var tuple: (thisWeek:[Date],nextWeek:[Date],thirthWeek:[Date],fourWeek:[Date],fiveWeek:[Date],sixWeek:[Date])
        
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        var arrThirdWeek: [Date] = []
        for i in 1...7 {
            arrThirdWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrNextWeek.last!)!)
        }
        var arrFourWeek: [Date] = []
        for i in 1...7 {
            arrFourWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThirdWeek.last!)!)
        }
        var arrFiveWeek: [Date] = []
        for i in 1...7 {
            arrFiveWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrFourWeek.last!)!)
        }
        var arrSixWeek: [Date] = []
        for i in 1...7 {
            arrSixWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrFiveWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek,nextWeek: arrNextWeek,thirthWeek: arrThirdWeek,fourWeek: arrFourWeek,fiveWeek: arrFiveWeek,sixWeek: arrSixWeek)
        return tuple
    }
    
    /**取得當地時區的正確時間*/
    func getTimeZoneDate() -> Date{
        let interval:Int = TimeZone.current.secondsFromGMT(for: self)
        let currentDate:Date = addingTimeInterval(Double(interval))
        
        return currentDate
    }
    
    /**取開始時間*/
    var startOfWeek: Date {
        let date = Date()
        var calendar = NSCalendar.current
        
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.yearForWeekOfYear, .weekOfYear]), from: date)
        calendar.firstWeekday = 2
        return calendar.date(from: components)!
    }
    
    /**取開始時間*/
    var startWeek: Date {
        let date = Date()
        var calendar = NSCalendar.current
        
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.yearForWeekOfYear, .weekOfYear]), from: date)
        calendar.firstWeekday = 3
        return calendar.date(from: components)!
    }
    
    /**取結束時間*/
    var endOfWeek: Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.day = 7
        return calendar.date(byAdding: components, to: self.startOfWeek)!
    }
    
    func toDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /**
     * 星期幾
     * 0=星期日 1=星期一 2=星期二 3=星期三 4=星期四 5=星期五 6=星期六
     */
    func getWeekDay() -> Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        
        return weekday
    }
    
    func getWeekDay(dateTime:String)->Int{
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFmt.date(from: dateTime)
//        date?.description
        let interval = Int(date!.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
}


