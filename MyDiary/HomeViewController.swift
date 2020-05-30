//
//  HomeViewController.swift
//  MyDiary
//
//  Created by maya on 2020/05/22.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var diaryTextView: UITextView!
    var diaryText: String!
    var dayText: String!
    
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    
    let now = Date()
    var calender = Calendar.current

    override func viewDidLoad() {
        super.viewDidLoad()
        let ym = calender.dateComponents([.year, .month, .day], from: now)
        diaryTextView.text = diaryText
        dayLabel.text = String(ym.month!) + "月" + String(ym.day!) + "日"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        calender.locale = Locale(identifier: "ja")
        let weekdaySymbols = calender.weekdaySymbols
        let year = calender.component(.year, from: now)
        let month = calender.component(.month, from: now)
        let day = calender.component(.day, from: now)
        let wday = calender.component(.weekday, from: now)
        let newDiary = Diary()
        dayText = "\(year) / \(month) / \(day) ( \(weekdaySymbols[wday - 1]))"
        
        diaryText = diaryTextView.text!
        newDiary.day = dayText
        newDiary.text = diaryText
        
        try! realm.write {
            if judgeSameDay(dayJudge: dayText) == -1 {
                realm.add(newDiary)
            } else {
                let sameDay = judgeSameDay(dayJudge: dayText)
                diaries[sameDay].text = newDiary.text
            }
        }
        
        
        let alert = UIAlertController(
            title: "保存完了",
            message: "日記を記録しました",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        present(alert, animated: true)
    }
    
    func judgeSameDay(dayJudge: String) -> Int{
        for i in 0..<diaries.count {
            if  dayJudge == diaries[i].day {
                    return i
            }
        }
        return -1
    }
    
    @IBAction func nextDay() {
        
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
