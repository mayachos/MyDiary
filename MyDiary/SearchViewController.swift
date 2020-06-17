//
//  SearchViewController.swift
//  MyDiary
//
//  Created by maya on 2020/06/06.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    let diaries = try! Realm().objects(Diary.self)
    let defaultText = ""
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    @IBOutlet weak var sceneLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var monthArray: Array<Int> = []
    var sceneArray: Array<String> = []
    var characterArray: Array<String> = []
    var timeArray: Array<String> = []
    var scenePickArray: Array<String> = []
    var characterPickArray: Array<String> = []
    var timePickArray: Array<String> = []
    
    func setArray() {
        for i in 0..<diaries.count {
            monthArray.append(diaries[i].month)
            sceneArray.append(diaries[i].scene)
            characterArray.append(diaries[i].character)
            timeArray.append(diaries[i].time)
        }
    }
    
    func setPicker() {
        setArray()
        for i in 0..<diaries.count {
            if judgeSame(array: sceneArray, i: i) || i == 0{
                scenePickArray.append(sceneArray[i])
            }
            if judgeSame(array: characterArray, i: i) || i == 0{
                characterPickArray.append(characterArray[i])
            }
            if judgeSame(array: timeArray, i: i) || i == 0{
                timePickArray.append(timeArray[i])
            }
        }
    }
    func judgeSame(array: Array<String>, i: Int) -> Bool {
        for j in 0..<i {
            if array[i] != array[j]{
                return true
            } else {
                return false
            }
        }
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        pickerView2?.selectRow(0, inComponent: 0, animated: false)
        pickerView3?.selectRow(0, inComponent: 0, animated: false)
        // Do any additional setup after loading the view.
        setPicker()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
               case 1:
                    return scenePickArray.count
               case 2:
                    return characterPickArray.count
               case 3:
                    return timePickArray.count
               default:
                   return 0
               }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            if component == 0 {
                return scenePickArray[row]
            } else {
                return "error"
            }
        case 2:
            if component == 0 {
                return characterPickArray[row]
                
            } else {
                return "error"
            }
        case 3:
            return timePickArray[row]
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
        if component == 0 {
            sceneLabel.text = scenePickArray[row]
            }
        case 2:
            if component == 0 {
            characterLabel.text = characterPickArray[row]
            }
        case 3:
            timeLabel.text = timePickArray[row]
        default:
            sceneLabel.text = defaultText
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toShow" {
             let nextView = segue.destination as! ShowViewController
            nextView.sceneText = sceneLabel.text
            nextView.characterText = characterLabel.text
            nextView.timeText = timeLabel.text
            nextView.setting = 1
         }
     }
    @IBAction func back() {
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
