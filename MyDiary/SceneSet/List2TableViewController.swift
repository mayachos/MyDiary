//
//  List2TableViewController.swift
//  MyDiary
//
//  Created by maya on 2020/06/17.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class List2TableViewController: UITableViewController {
    var scene: [String] = []
    var sceneDic: [String:[String]] = [:]
    var character: [String] = []
    var characterDic: [String:[String]] = [:]
    var timeArray: [String] = []
    var sItem : [sceneI] = []
    let cItem = charaI()
    let tItem = timeI()
    var getCell: Int!
    var getSction: Int!
    
    func sceneInstance() {
        //let someScenes = realm.objects(sceneItem.self)
        self.scene += ["登録しない","学校", "家", "レジャー施設", "お店"]
        self.sceneDic[scene[0]] = [" "]
        self.sceneDic[scene[1]] = ["教室", "体育館", "グラウンド", "校庭", "図書室"]
        self.sceneDic[scene[2]] = ["リビング", "キッチン", "寝室", "お風呂・トイレ"]
        self.sceneDic[scene[3]] = ["動物園", "遊園地", "水族館", "公園", "海"]
        self.sceneDic[scene[4]] = ["レストラン", "コンビニ", "スーパー", "カフェ", "デパート"]
    }
    func characterInstance() {
        self.character += ["登録しない", "家族", "友達・恋人", "仕事関係", "その他"]
        self.characterDic[character[0]] = [" "]
        self.characterDic[character[1]] = ["自分", "親", "兄弟・姉妹", "親戚"]
        self.characterDic[character[2]] = ["幼馴染", "恋人"]
        self.characterDic[character[3]] = ["上司・先輩", "部下・後輩", "同僚"]
        self.characterDic[character[4]] = ["見知らぬ人", "店員", "幽霊", "その他"]
    }
    func timeInstance() {
        self.timeArray += ["登録しない", "朝", "昼", "夕方", "夜", "深夜"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.register(UINib(nibName: "List2TableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
        tableView.delegate = self
        tableView.dataSource = self
        setRealm()
        //let itemt = realm.objects(timeI.self)
        //sceneDic[scene[getCell]]! += items.sceneName
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    func setRealm() {
        sceneInstance()
        characterInstance()
        timeInstance()
        let realm = try! Realm()
        let sitem = realm.objects(sceneI.self)
        let items = realm.objects(sceneItem.self)
        var sDic: [String:[String]] = [:]
        
        let itemc = realm.objects(charaItem.self)
        for i in 0..<items.count {
            print(sItem.count)
            sceneDic.append(items[i].sceneName)
        }
        for i in 0..<itemc.count {
            character.append(itemc[i].Chara)
        }
        //        try! realm.write {
        //            //realm.add(sItem)
        //            realm.add(cItem)
        //            realm.add(tItem)
        //            }
    }
    
    func selectSection() -> [String]{
        let sArray = sceneDic[scene[getCell]] ?? [""]
        let cArray = characterDic[character[getCell]] ?? [""]
        switch getSction {
        case 0:
            return sArray
        case 1:
            return cArray
        default:
            return [""]
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toAdd" {
            let nextView = segue.destination as! AddViewController
            nextView.selectSec = getSction
            nextView.selectCell = getCell
         }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectSection().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! List2TableViewCell
            cell.t2Label.text = selectSection()[indexPath.row]
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
