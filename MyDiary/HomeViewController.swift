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

    override func viewDidLoad() {
        super.viewDidLoad()
        

        diaryTextView.text = diaryText
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
        let newDiary = Diary()
        dayText = day()
        diaryText = diaryTextView.text!
        newDiary.day = dayText
        newDiary.text = diaryText
        
        try! realm.write {
            realm.add(newDiary)
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
