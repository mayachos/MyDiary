//
//  ShowSearchViewController.swift
//  MyDiary
//
//  Created by maya on 2020/06/06.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class ShowSearchViewController: UIViewController {
    
     @IBOutlet var showTextView: UITextView!
     @IBOutlet var searchLabel: UILabel!
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
     var sceneText: String!
     var characterText: String!
     var timeText: String!
     
//     func calenderInstance() {
//         calender.locale = Locale(identifier: "ja")
//         year = calender.component(.year, from: now)
//         month = calender.component(.month, from: now)
//     }
     
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
         //calenderInstance()
         searchLabel.text = sceneText
         appearView()
         //monthAppear = month
     }
     
     
    func sameJudge(m: String, searchWord: String) -> Bool {
         if (m == searchWord) {
             return true;
         } else {
             return false;
         }
     }
     func appearView() {
         for i in 0..<textArray.count {
             if (sameJudge(m: sceneArray[i], searchWord: sceneText) ||
                sameJudge(m: characterArray[i], searchWord: characterText) ||
                sameJudge(m: timeArray[i], searchWord: timeText)) {
                 monthDiary = monthDiary + dayArray[i] + "\n\n" + textArray[i] + "\n #" + sceneArray[i] + " #" + characterArray[i] + " #" + timeArray[i] + "\n\n\n"
             }
         }
         showTextView.text = monthDiary
     }
     @IBAction func back(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
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
