//
//  AppDelegate.swift
//  MyDiary
//
//  Created by maya on 2020/05/20.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { miragration, oldSchemaVersion in
                if(oldSchemaVersion < 1) {
                                                
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
          schemaVersion: 5,
          migrationBlock: { migration, oldSchemaVersion in
            migration.enumerateObjects(ofType: Diary.className()) { oldObject, newObject in
              if oldSchemaVersion < 3 {
                newObject!["detailScene"] = ""
              }
            }
            migration.enumerateObjects(ofType: Diary.className()) { oldObject, newObject in
              if oldSchemaVersion < 3 {
                newObject!["detailCharacter"] = ""
              }
            }
            migration.enumerateObjects(ofType: sceneI.className()) { oldObject, newObject in
              if oldSchemaVersion < 3 {
                newObject!["Scene"] = ""
              }
            }
            migration.enumerateObjects(ofType: charaI.className()) { oldObject, newObject in
              if oldSchemaVersion < 3 {
                newObject!["Character"] = ""
              }
            }
            migration.enumerateObjects(ofType: timeI.className()) { oldObject, newObject in
              if oldSchemaVersion < 3 {
                newObject!["Times"] = ""
              }
            }
            migration.enumerateObjects(ofType: sceneItem.className())  { oldObject, newObject in
                if oldSchemaVersion < 2 {
                  newObject!["sceneName"] = ""
                }
            }
            migration.enumerateObjects(ofType: charaItem.className())  { oldObject, newObject in
                if oldSchemaVersion < 2 {
                    newObject!["Chara"] = ""
                }
            }
          })

        // Realmは自動的にマイグレーションを実行し、成功したらRealmを開きます。
        //let realm = try! Realm()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

