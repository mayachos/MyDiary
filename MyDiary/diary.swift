//
//  diary.swift
//  MyDiary
//
//  Created by maya on 2020/05/24.
//  Copyright © 2020 maya. All rights reserved.
//

import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var  month: Int = 0
    @objc dynamic var day: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var scene: String = ""
    @objc dynamic var character: String = ""
    @objc dynamic var time: String = ""
}
