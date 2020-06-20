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
    @IBOutlet var appearLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var preButton: UIButton!
    @IBOutlet var imageview: UIImageView!
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)//.sorted(byKeyPath: "day")
    let now = Date()
    var calender = Calendar.current
    var setting: Int = 0
    let MONTH = 202005
    
   // var nowyear: Int!
   // var nowmonth:  Int!
    var year: Int!
    var month: Int!
    var monthAppear: Int = 0
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
    var imageCount: Int = 0
    
    func calenderInstance() {
        calender.locale = Locale(identifier: "ja")
        year = calender.component(.year, from: now)
        month = calender.component(.month, from: now)
    }
    
    func imageSet() {
        //var imageArray: [UIImage] = []
        var ma = monthAppear
        switch ma {
         case 6:
             imageCount = 29
         case 7:
             imageCount = 29
         case 8:
             imageCount = 27
         case 9:
             imageCount = 29
         default:
            imageCount = 0
              }
            //print(imageCount)
        var len = Array<Int>(repeating: 0, count: 12)
        for j in 0..<len.count {
            for i in 0..<monthArray.count {
                if monthJudge(m: monthArray[i], count: j) { len[j + 6] += 1 }
                //print(monthArray[i])
            }
        }
        if ma == 12 { ma = 0 }
        if ma == -1 { ma = 11 }
        if len[ma] < imageCount  && len[ma] >= 0
            && imageCount != 0 {
            self.imageview.image = UIImage(named: imageMonth(index: len[ma]))
            //self.view.addBackground(name: imageMonth(index: len))
        } else if len[ma] >= imageCount {
             self.imageview.image = UIImage(named: imageMonth(index: imageCount-1))
           // self.view.addBackground(name: imageMonth(index: imageCount))
        }
    }
    
    func imageMonth(index: Int) -> String{
        switch monthAppear {
        case 6:
            imageCount = 29
            return "R_\(index).PNG"
        case 7:
            imageCount = 29
            return "O_\(index).PNG"
        case 8:
            imageCount = 27
            return "Y_\(index).PNG"
        case 9:
            imageCount = 29
            return "G_\(index).PNG"
        default:
            return "R_\(index).PNG"
             }
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
        if setting == 1 {
            nextButton.isHidden = true
            preButton.isHidden = true
        } else if setting == 0 {
            print(diaries.count)
            nextButton.isHidden = false
            preButton.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showTextView.layer.borderWidth = 2
        showTextView.layer.cornerRadius = 10
        if setting == 0 {
            calenderInstance()
            appearLabel.text = String(month) + "月"
            monthAppear = month
            appearView(c: monthCount)
        } else if setting == 1 {
            appearLabel.text = "検索結果"
            appearView()
        }
    }
    
    @IBAction func preMonth() {
        if setting == 0 && MONTH < year * 100 + month + monthCount{
            monthDiary = ""
            if monthAppear > 1 {
                monthAppear -= 1
                monthCount -= 1
            } else if monthAppear == 1 {
                monthAppear = 12
                monthCount -= 89
            }
            appearLabel.text = String(monthAppear) + "月"
            appearView(c: monthCount)
        }
    }
    
    @IBAction func nextMonth() {
        //nowyear = calender.component(.year, from: now)
        //nowmonth = calender.component(.month, from: now)
        if setting == 0 {
            monthDiary = ""
            if monthAppear < 12 {
                monthAppear += 1
                monthCount += 1
            } else if monthAppear == 12 {
                monthAppear = 1
                monthCount += 89
            }
            appearLabel.text = String(monthAppear) + "月"
            appearView(c: monthCount)
        }
       }
    
    func monthJudge(m: Int, count: Int) -> Bool {
        calenderInstance()
        if (m == year * 100 + month + count) {
            return true;
        } else {
            return false;
        }
    }
    
    func sameJudge(m: String, searchWord: String) -> Bool {
         if (m == searchWord) {
             return true;
         } else {
             return false;
         }
     }
    
    func appearView(c: Int) {
        for i in 0..<textArray.count {
            if (monthJudge(m: monthArray[i], count: c)) {
                monthDiary = monthDiary + dayArray[i] + "\n\n" + textArray[i] + "\n"
                if sceneHidden(text: sceneArray[i]) { monthDiary += " #" + sceneArray[i] }
                if sceneHidden(text: characterArray[i]) { monthDiary += " #" + characterArray[i] }
                if sceneHidden(text: timeArray[i]) { monthDiary += " #" + timeArray[i] }
                monthDiary += "\n\n\n"
            }
        }
        imageSet()
        showTextView.text = monthDiary
    }
    
    func appearView() {
        for i in 0..<textArray.count {
            if (sameJudge(m: sceneArray[i], searchWord: sceneText) ||
                sameJudge(m: characterArray[i], searchWord: characterText) ||
                sameJudge(m: timeArray[i], searchWord: timeText)) {
                monthDiary = monthDiary + dayArray[i] + "\n\n" + textArray[i] + "\n"
                if sceneHidden(text: sceneArray[i]) { monthDiary += " #" + sceneArray[i] }
                if sceneHidden(text: characterArray[i]) { monthDiary += " #" + characterArray[i] }
                if sceneHidden(text: timeArray[i]) { monthDiary += " #" + timeArray[i] }
                monthDiary += "\n\n\n"
                
            }
        }
        showTextView.text = monthDiary
    }
    func sceneHidden(text: String) -> Bool{
        if text == "" {
            return false
        } else {
            return true
        }
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
extension UIView {
    func addBackground(name: String) {
        // スクリーンサイズの取得
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        
        // スクリーンサイズにあわせてimageViewの配置
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        //imageViewに背景画像を表示
        imageViewBackground.image = UIImage(named: name)

        // 画像の表示モードを変更。
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        // subviewをメインビューに追加
        self.addSubview(imageViewBackground)
        // 加えたsubviewを、最背面に設置する
        self.sendSubviewToBack(imageViewBackground)
    }
}
