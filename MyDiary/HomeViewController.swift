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
    var monthText: Int!
    var sceneText: String = ""
    var characterText: String = ""
    var timeText: String = ""
    
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    var weekdaySymbols: [String]!
    var year: Int!
    var month: Int!
    var day: Int!
    var wday: Int!
    let newDiary = Diary()
    
    let now = Date()
    var calender = Calendar.current
    
    func calenderInstance() {
        calender.locale = Locale(identifier: "ja")
        weekdaySymbols = calender.weekdaySymbols
        year = calender.component(.year, from: now)
        month = calender.component(.month, from: now)
        day = calender.component(.day, from: now)
        wday = calender.component(.weekday, from: now)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calenderInstance()
        dayLabel.text = String(month) + "月" + String(day) + "日"
        let appearDay: String = "\(String(describing: year!)) / \(String(describing: month!)) / \(String(describing: day!)) ( \(weekdaySymbols[wday - 1]))"
        if judgeSameDay(dayJudge: appearDay) == -1 {
            diaryTextView.text = diaryText
        } else {
            let sameDay = judgeSameDay(dayJudge: appearDay)
            diaryTextView.text = diaries[sameDay].text
        }
    }
    
    @IBAction func save() {
        calenderInstance()
        dayText = "\(String(describing: year!)) / \(String(describing: month!)) / \(String(describing: day!)) ( \(weekdaySymbols[wday - 1]))"
        monthText = year * 100 + month
        diaryText = diaryTextView.text!
        newDiary.month = monthText
        newDiary.day = dayText
        newDiary.text = diaryText
        if noItem(n: sceneText) { newDiary.scene = sceneText }
        if noItem(n: characterText) { newDiary.character = characterText }
        if noItem(n: timeText) { newDiary.time = timeText }
        
        try! realm.write {
            if judgeSameDay(dayJudge: dayText) == -1 {
                realm.add(newDiary)
            } else {
                let sameDay = judgeSameDay(dayJudge: dayText)
                diaries[sameDay].month = monthText
                diaries[sameDay].text = newDiary.text
                diaries[sameDay].scene = newDiary.scene
                diaries[sameDay].character = newDiary.character
                diaries[sameDay].time = newDiary.time
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
    @IBAction func showView(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(identifier: "SHOW")
        self.present(second, animated: true, completion: nil)
        //self.performSegue(withIdentifier: "fromHomeToShow", sender: nil)
    }
    
    @IBAction func sceneView(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(identifier: "SCENE")
        self.present(second, animated: true, completion: nil)
        //self.performSegue(withIdentifier: "toScene", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScene" {
            let nextView = segue.destination as! SceneSettingViewController
            nextView.resultHandler1 = { sceneSet in
                self.sceneText = sceneSet
            }
            nextView.resultHandler2 = { characterSet in
                self.characterText = characterSet
            }
            nextView.resultHandler3 = { timeSet in
                self.timeText = timeSet
            }
        }
        if segue.identifier == "fromHomeToShow" {
            let nextView = segue.destination as! ShowViewController
            nextView.setting = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func noItem(n:String)->Bool {
        if n == "登録しない" { return false }
        return true
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
