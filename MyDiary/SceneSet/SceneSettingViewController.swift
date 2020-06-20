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
    
    let userDefaults = UserDefaults.standard
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    let defaultText = ""
    let defaultNumber = 0
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    @IBOutlet weak var sceneLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var scene: [String] = ["登録しない","学校", "家", "レジャー施設", "お店"]
    var sceneDic: [String:[String]] = [:]
    var character: [String] = ["登録しない", "家族", "友達・恋人", "仕事関係", "その他"]
    var characterDic: [String:[String]] = [:]
    var timeArray: [String] = ["登録しない", "朝", "昼", "夕方", "夜", "深夜"]
    var resultHandler1: ((String) -> Void)?
    var resultHandler2: ((String) -> Void)?
    var resultHandler3: ((String) -> Void)?
    
    
    func sceneInstance() {
        self.sceneDic[scene[0]] = [" "]
        self.sceneDic[scene[1]] = ["教室", "体育館", "グラウンド", "校庭", "図書室"]
        self.sceneDic[scene[2]] = ["リビング", "キッチン", "寝室", "お風呂・トイレ"]
        self.sceneDic[scene[3]] = ["動物園", "遊園地", "水族館", "公園", "海"]
        self.sceneDic[scene[4]] = ["レストラン", "コンビニ", "スーパー", "カフェ", "デパート"]
    }
    func characterInstance() {
        self.characterDic[character[0]] = [" ", "", "", "", ""]
        self.characterDic[character[1]] = ["自分", "親", "兄弟・姉妹", "親戚"]
        self.characterDic[character[2]] = ["幼馴染", "恋人"]
        self.characterDic[character[3]] = ["上司・先輩", "部下・後輩", "同僚"]
        self.characterDic[character[4]] = ["見知らぬ人", "店員", "幽霊", "その他"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //definesPresentationContext = true
        sceneInstance()
        characterInstance()
        for i in 0..<scene.count {
            if userDefaults.array(forKey: scene[i]) != nil {
                let setArray = userDefaults.array(forKey: scene[i]) as! [String]
                sceneDic[scene[i]]! += setArray
            }
        }
        for i in 0..<character.count {
              if userDefaults.array(forKey: character[i]) != nil {
                  let charaArray = userDefaults.array(forKey: character[i]) as! [String]
                  characterDic[character[i]]! += charaArray
              }
          }
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
                return sceneDic[scene[pickerView.selectedRow(inComponent: 0)]]!.count
            } else {
                return 0
            }
        case 2:
            if component == 0 {
                return character.count
            } else if component == 1 {
                return characterDic[character[pickerView.selectedRow(inComponent: 0)]]!.count
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
                pickerView.reloadComponent(1)
                return scene[row]
            } else if component == 1 {
                return sceneDic[scene[pickerView.selectedRow(inComponent: 0)]]?[row]
            } else {
                return "error"
            }
        case 2:
            if component == 0 {
                pickerView.reloadComponent(1)
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
    
    @IBAction func back(_ sender: Any) {
        let sceneSet = self.sceneLabel.text ?? defaultText
        let characterSet = self.characterLabel.text ?? defaultText
        let timeSet = self.timeLabel.text ?? defaultText
        
        if let handler1 = self.resultHandler1 {
            print(sceneSet)
            handler1(sceneSet)
        }
        if let handler2 = self.resultHandler2 {
            handler2(characterSet)
        }
        if let handler3 = self.resultHandler3 {
            handler3(timeSet)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//          if segue.identifier == "toHome" {
//              let nextView = segue.destination as! HomeViewController
//              nextView.sceneText = sceneLabel.text
//              nextView.characterText = characterLabel.text
//              nextView.timeText = timeLabel.text
//          }
//      }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
