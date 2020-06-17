//
//  item.swift
//  MyDiary
//
//  Created by maya on 2020/06/13.
//  Copyright © 2020 maya. All rights reserved.
//

import Foundation
import RealmSwift

class sceneI: Object {
    @objc dynamic var Scene: String = ""
    let scenes = List<sceneItem>()
}
class charaI: Object {
    @objc dynamic var Character: String = ""
    let characters = List<charaItem>()
}
class timeI: Object {
    @objc dynamic var Times: String = ""
}

class sceneItem: Object {
    @objc dynamic var sceneName: String = ""
}

class charaItem: Object {
    @objc dynamic var Chara: String = ""
}
