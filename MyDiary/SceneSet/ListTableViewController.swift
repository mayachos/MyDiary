//
//  ListTableViewController.swift
//  MyDiary
//
//  Created by maya on 2020/06/16.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController {
    var scene: [String] = []
    var character: [String] = []
    var timeArray: [String] = []
    var sItem : [sceneI] = []
    let cItem = charaI()
    let tItem = timeI()
    var chosenCell: Int!
    var chosenSction: Int!
    
    func sceneInstance() {
        //let someScenes = realm.objects(sceneItem.self)
        self.scene += ["登録しない","学校", "家", "レジャー施設", "お店"]
    }
    func characterInstance() {
        self.character += ["登録しない", "家族", "友達・恋人", "仕事関係", "その他"]
    }
    func timeInstance() {
        self.timeArray += ["登録しない", "朝", "昼", "夕方", "夜", "深夜"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        setRealm()
        //let items = realm.objects(sceneI.self)
        //let itemc = realm.objects(charaI.self)
        //let itemt = realm.objects(timeI.self)

//        catch {
//                print("error")
//            }
//        for i in 0..<items.count {
//            s.append(items[i].Scene)
//        }
//        for i in 0..<itemc.count {
//            c.append(itemc[i].Character)
//        }
//        for i in 0..<itemt.count {
//            t.append(itemt[i].Times)
//        }
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
        for i in 0..<sItem.count {
            print(sItem.count)
            if sItem[i].Scene.isEmpty {
                sItem[i].Scene = scene[i]
                try! realm.write { realm.add(sItem) }
            }
        }
        for i in 0..<character.count { cItem.Character = character[i] }
        for i in 0..<timeArray.count { tItem.Times = timeArray[i] }
//        try! realm.write {
//            //realm.add(sItem)
//            realm.add(cItem)
//            realm.add(tItem)
//            }
    }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return scene.count
        } else if section == 1 {
            return character.count
        } else if section == 2 {
            return timeArray.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        if indexPath.section == 0 {
            cell.tLabel.text = scene[indexPath.row]
        } else if indexPath.section == 1 {
            cell.tLabel.text = character[indexPath.row]
        } else if indexPath.section == 2 {
            cell.tLabel.text = timeArray[indexPath.row]
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section < 2 {
        chosenSction = indexPath.section
        chosenCell = indexPath.row
        performSegue(withIdentifier: "toList2ViewController", sender: nil)
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let secVC: List2TableViewController = (segue.destination as? List2TableViewController)!
        secVC.getSction = chosenSction
        secVC.getCell = chosenCell
    }
    

}
