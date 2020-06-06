//
//  ShowViewController.swift
//  MyDiary
//
//  Created by maya on 2020/05/23.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class ShowViewController: UIViewController {
    
    @IBOutlet var showTextView: UITextView!
    @IBOutlet var monthLabel: UILabel!
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    let now = Date()
    var calender = Calendar.current
    
   // var nowyear: Int!
   // var nowmonth:  Int!
    var year: Int!
    var month: Int!
    var monthAppear: Int!
    var textArray: Array<String> = []
    var dayArray: Array<String> = []
    var monthArray: Array<Int> = []
    var monthDiary: String = ""
    var sceneArray: Array<String> = []
    var characterArray: Array<String> = []
    var timeArray: Array<String> = []
    var monthCount: Int = 0
    
    func calenderInstance() {
        calender.locale = Locale(identifier: "ja")
        year = calender.component(.year, from: now)
        month = calender.component(.month, from: now)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        for i in 0..<diaries.count {
            monthArray.append(diaries[i].month)
            textArray.append(diaries[i].text)
            dayArray.append(diaries[i].day)
            sceneArray.append(diaries[i].scene)
            characterArray.append(diaries[i].character)
            timeArray.append(diaries[i].time)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        calenderInstance()
        monthLabel.text = String(month)
        appearView(c: monthCount)
        monthAppear = month
    }
    
    @IBAction func preMonth() {
        monthDiary = ""
        if monthAppear > 1 {
            monthAppear -= 1
            monthCount -= 1
            print(monthAppear as Any)
            print(monthCount as Any)
        } else if monthAppear == 1 {
            monthAppear = 12
            monthCount -= 89
        }
        monthLabel.text = String(monthAppear)
        appearView(c: monthCount)
    }
    
    @IBAction func nextMonth() {
        //nowyear = calender.component(.year, from: now)
        //nowmonth = calender.component(.month, from: now)
           monthDiary = ""
           if monthAppear < 12 {
               monthAppear += 1
               monthCount += 1
               print(monthCount as Any)
           } else if monthAppear == 12 {
               monthAppear = 1
               monthCount += 89
           }
           monthLabel.text = String(monthAppear)
           appearView(c: monthCount)
       }
    
    func monthJudge(m: Int, count: Int) -> Bool {
        calenderInstance()
        if (m == year * 100 + month + count) {
            return true;
        } else {
            return false;
        }
    }
    func appearView(c: Int) {
        for i in 0..<textArray.count {
            if (monthJudge(m: monthArray[i], count: c)) {
                monthDiary = monthDiary + dayArray[i] + "\n\n" + textArray[i] + "\n #" + sceneArray[i] + " #" + characterArray[i] + " #" + timeArray[i] + "\n\n\n"
            }
        }
        showTextView.text = monthDiary
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
