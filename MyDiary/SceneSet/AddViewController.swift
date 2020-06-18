//
//  AddViewController.swift
//  MyDiary
//
//  Created by maya on 2020/06/16.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    @IBOutlet var sTextField: UITextField!
    var sDic: [String] = []
    var cDic: [String] = []
    var selectSec: Int = 0
    var selectCell: Int = 0
    let userDefaults = UserDefaults.standard
    var scene: [String] = ["登録しない","学校", "家", "レジャー施設", "お店"]
    var character: [String] = ["登録しない", "家族", "友達・恋人", "仕事関係", "その他"]
    //var timeArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<scene.count {
            if userDefaults.array(forKey: scene[i]) != nil {
                let setArray = userDefaults.array(forKey: scene[i]) as! [String]
                sDic += setArray
            }
        }
        for i in 0..<character.count {
             if userDefaults.array(forKey: character[i]) != nil {
                 let charaArray = userDefaults.array(forKey: character[i]) as! [String]
                 sDic += charaArray
             }
         }
        // Do any additional setup after loading the view.
    }

    @IBAction func add() {
        print(selectSec)
        print(selectCell)
        if sTextField.text != "" {
            if selectSec == 0 {
                sDic.append(sTextField.text!)
                userDefaults.set(sDic, forKey: scene[selectCell])
            } else if selectSec == 1 {
                cDic.append(sTextField.text!)
                userDefaults.set(cDic, forKey: character[selectCell])
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
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
