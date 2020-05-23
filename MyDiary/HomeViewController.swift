//
//  HomeViewController.swift
//  MyDiary
//
//  Created by maya on 2020/05/22.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var diaryTextView: UITextView!
    var textArray: Array<String> = []
    var dayArray: Array<String> = []
    let saveData = UserDefaults.standard
    let saveDay = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.array(forKey: "text") != nil {
            textArray = saveData.array(forKey: "text") as! Array<String>
        }
        if saveDay.array(forKey: "day") != nil {
            dayArray = saveDay.array(forKey: "day") as! Array<String>
        }
        
        for i in 0..<textArray.count {
        diaryTextView.text = textArray[i]
        }
        dayLabel.text = day()

        // Do any additional setup after loading the view.
    }
    
    func day() -> String {
        let f = DateFormatter()
        f.dateStyle = .full
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = "yy/MM/dd(EEE)"
        let now = Date()
        return f.string(from: now)
    }
    
    
    @IBAction func save() {
        dayArray.append(day())
        
        if diaryTextView.text != nil {
            textArray.append(diaryTextView.text)
        }
        saveData.set(textArray, forKey: "text")
        saveDay.set(dayArray, forKey: "day")
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
