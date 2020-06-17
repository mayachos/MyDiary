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
    //@IBOutlet var tTextField: UITextField!
    
    //var SArray: [String] = []
    //var CArray: [String] = []
    //var tArray: [String] = []
    var SDic: [String:[String]] = [:]
    var cDic: [String:[String]] = [:]
    let sItem = sceneI()
    let sitem = sceneItem()
    let cItem = charaI()
    let citem = charaItem()
    var selectSec: Int = 0
    var selectCell: Int = 0
    //let tItem = timeI()
    var scene: [String] = []
    var character: [String] = []
    var timeArray: [String] = []
    
    func sceneInstance() {
        self.scene += ["登録しない","学校", "家", "レジャー施設", "お店"]
    }
    func characterInstance() {
        self.character += ["登録しない", "家族", "友達・恋人", "仕事関係", "その他"]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    func setRealm() {
//        let realm = try! Realm()
//        if sTextField.text != "" && selectSec == 0{
//            sItem.Scene = scene[selectCell]
//            sitem.sceneName = sTextField.text!
//            print(sItem.Scene)
//        try! realm.write {
//            realm.add(sItem)
//            realm.add(sitem)
//            }
//        }
//        if cTextField.text != "" && selectSec == 1{
//            cItem.Character = character[selectCell]
//            cItem.Character = cTextField.text!
//        try! realm.write { realm.add(cItem) }
//        }
//        if tTextField.text != "" {
//            tItem.Times = tTextField.text!
//        try! realm.write { realm.add(tItem) }
//        }
 //   }
    @IBAction func add() {
        sceneInstance()
        characterInstance()
        let realm = try! Realm()
        print(selectSec)
        print(selectCell)
        if sTextField.text != ""{
            if selectSec == 0 {
                sItem.Scene = scene[selectCell]
                sitem.sceneName = sTextField.text!
                print(sItem.Scene)
                try! realm.write {
                    realm.add(sItem)
                    realm.add(sitem)
                }
            } else if selectSec == 1 {
                cItem.Character = character[selectCell]
                cItem.Character = sTextField.text!
                try! realm.write {
                    realm.add(cItem)
                    realm.add(citem)
                }
            }
        }
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
