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
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    
    var textArray: Array<String> = []
    var dayArray: Array<String> = []
    var monthDiary: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        for i in 0..<diaries.count {
            textArray.append(diaries[i].text)
            dayArray.append(diaries[i].day)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
        for i in 0..<textArray.count {
            monthDiary = monthDiary + dayArray[i] + "\n\n" + textArray[i] + "\n"
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
