//
//  ShowViewController.swift
//  MyDiary
//
//  Created by maya on 2020/05/23.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet var showTextView: UITextView!
    var textArray: Array<String> = []
    var dayArray: Array<String> = []
    let saveData = UserDefaults.standard
    let saveDay = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: "text") != nil {
            textArray = saveData.array(forKey: "text") as! Array<String>
        }
        if saveDay.array(forKey: "day") != nil {
            dayArray = saveDay.array(forKey: "day") as! Array<String>
        }
        
        for i in 0..<textArray.count {
            showTextView.text = dayArray[i] + "\n\n" + textArray[i]
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
