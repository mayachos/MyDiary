//
//  SceneSettingViewController.swift
//  MyDiary
//
//  Created by maya on 2020/05/29.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

//protocol DataSend {
//    func sendData(data: String)
//}
class SceneSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    let defaultText = ""
//    var dele: DataSend?
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    @IBOutlet weak var sceneLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var scene: [String] = []
    var sceneDic: [String:[String]] = [:]
    var character: [String] = []
    var characterDic: [String:[String]] = [:]
    var timeArray: [String] = []
    
    func sceneInstance() {
        self.scene += ["学校", "家", "レジャー施設", "お店"]
        self.sceneDic[scene[0]] = ["教室", "体育館", "グラウンド", "校庭"]
        self.sceneDic[scene[1]] = ["リビング", "キッチン", "寝室", "お風呂・トイレ"]
        self.sceneDic[scene[2]] = ["動物園", "遊園地", "水族館", "公園"]
        self.sceneDic[scene[3]] = ["レストラン", "コンビニ", "スーパー", "カフェ"]
    }
    func characterInstance() {
        self.character += ["家族", "友達・恋人", "仕事関係", "その他"]
        self.characterDic[character[0]] = ["自分", "親", "兄弟・姉妹", "親戚"]
        self.characterDic[character[1]] = ["幼馴染・学生", "同僚", "恋人", "妻・夫"]
        self.characterDic[character[2]] = ["上司・先輩", "部下・後輩", "同僚", "取引先"]
        self.characterDic[character[3]] = ["見知らぬ人", "店員・従業員", "幽霊", "その他"]
    }
    func timeInstance() {
        self.timeArray += ["朝", "昼", "夕方", "夜", "深夜"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneInstance()
        characterInstance()
        timeInstance()
        pickerView1.tag = 1
        pickerView2.tag = 2
        pickerView3.tag = 3
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        pickerView1?.selectRow(0, inComponent: 0, animated: false)
        pickerView1?.selectRow(1, inComponent: 1, animated: false)
        pickerView2?.selectRow(0, inComponent: 0, animated: false)
        pickerView2?.selectRow(1, inComponent: 1, animated: false)
        pickerView3?.selectRow(0, inComponent: 0, animated: false)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 3 {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            if component == 0 {
                return scene.count
            } else if component == 1 {
                return sceneDic.count
            } else {
                return 0
            }
        case 2:
            if component == 0 {
                return character.count
            } else if component == 1 {
                return characterDic.count
            } else {
                return 0
            }
        case 3:
            if component == 0 {
                return timeArray.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            if component == 0 {
                return scene[row]
            } else if component == 1 {
                return sceneDic[scene[pickerView.selectedRow(inComponent: 0)]]?[row]
            } else {
                return "error"
            }
        case 2:
            if component == 0 {
                return character[row]
            } else if component == 1 {
                return characterDic[character[pickerView.selectedRow(inComponent: 0)]]?[row]
            } else {
                return "error"
            }
        case 3:
            return timeArray[row]
        default:
            return "error"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
        if component == 0 {
            sceneLabel.text = scene[row]
        } else if component == 1 {
            sceneLabel.text = scene[pickerView.selectedRow(inComponent: 0)] + ": " + (sceneDic[scene[pickerView.selectedRow(inComponent: 0)]]?[row] ?? defaultText)
        }
        case 2:
            if component == 0 {
                characterLabel.text = character[row]
            } else if component == 1 {
                characterLabel.text = character[pickerView.selectedRow(inComponent: 0)] + ": " + (characterDic[character[pickerView.selectedRow(inComponent: 0)]]?[row] ?? defaultText)
            }
        case 3:
            timeLabel.text = timeArray[row]
        default:
            sceneLabel.text = defaultText
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            let nextView = segue.destination as! HomeViewController
            nextView.sceneText = sceneLabel.text
            nextView.characterText = characterLabel.text
            nextView.timeText = timeLabel.text
        }
    }
//    @IBAction func register() {
////        dele?.sendData(data: sceneLabel.text ?? defaultText)
//        dismiss(animated: true, completion: nil)
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
