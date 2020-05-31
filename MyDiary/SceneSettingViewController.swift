//
//  SceneSettingViewController.swift
//  MyDiary
//
//  Created by maya on 2020/05/29.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class SceneSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    @IBOutlet weak var sceneLabel: UILabel!
    
    var scene: [String] = []
    var sceneDic: [String:[String]] = [:]
    var character: [String] = []
    var characterDic: [String:[String]] = [:]
    
    func sceneInstance() {
        self.scene += ["学校", "家", "レジャー施設", "お店"]
        self.sceneDic[scene[0]] = ["教室", "体育館", "グラウンド", "校庭"]
        self.sceneDic[scene[1]] = ["リビング", "キッチン", "寝室", "お風呂・トイレ"]
        self.sceneDic[scene[2]] = ["動物園", "遊園地", "水族館", "公園"]
        self.sceneDic[scene[3]] = ["レストラン", "コンビニ", "スーパー", "カフェ"]
    }
    func characterInstance() {
        self.character += ["家族", "友達", "仕事関係", "その他"]
        self.characterDic[character[0]] = ["自分", "親", "兄弟・姉妹", "親戚"]
        self.characterDic[character[1]] = ["幼馴染・学生", "同僚", "その他"]
        self.characterDic[character[2]] = ["上司・先輩", "部下・後輩", "同僚", "取引先"]
        self.characterDic[character[3]] = ["見知らぬ人", "店員・従業員", "幽霊"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneInstance()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1?.selectRow(0, inComponent: 0, animated: false)
        pickerView1?.selectRow(1, inComponent: 1, animated: false)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return scene.count
        } else if component == 1 {
            return sceneDic.count
        } else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return scene[row]
        } else if component == 1{
            return sceneDic[scene[pickerView.selectedRow(inComponent: 0)]]?[row]
        } else {
            return "error"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            sceneLabel.text = scene[row]
        } else {
            sceneLabel.text = sceneDic[scene[pickerView.selectedRow(inComponent: 0)]]?[row]
        }
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
