//
//  AppDelegate.swift
//  Moment-English-composition
//
//  Created by 信次　智史 on 2019/03/30.
//  Copyright © 2019 stoshi nobutsugu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults()
    let isInitKey: String = "initialLaunch"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // 初回起動処理
        // 初期値設定
        defaults.register(defaults: [isInitKey: true])
        // データの同期
        defaults.synchronize()
        
        // TODO 実行タイミングを考える
//        if defaults.bool(forKey: isInitKey) == true {
            print("initial setup start")
            self.initialSetUp()
//        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func initialSetUp() {
        // マイグレーション
        self.realmMigration()
        // シードデータ投入
        if defaults.bool(forKey: isInitKey) == true {
            self.insertSeedData()
        }
        // 初回起動済みフラグを立てる
        self.defaults.set(false, forKey: isInitKey)
        self.defaults.synchronize()
    }
    
    func realmMigration() {
        let config = Realm.Configuration(
            // 新しいスキーマバージョンを記述
            // 以前のバージョンより大きくなければならない
            schemaVersion: 2,
            // マイグレーション処理を実行
            // 古いスキーマバージョンのRealmを開こうとすると自動的にマイグレーションが実行される
            migrationBlock: { (migration, oldSchemaVersion) in
                if (oldSchemaVersion < 1) {
                    // 何もする必要なし
                    // Realmは自動的に新しく追加されたプロパティと、解除されたプロパティを認識し、自動で気にスキーマをアップデートする
                }
            })
        // デフォルトRealmに新しい設定を適用する
        Realm.Configuration.defaultConfiguration = config
        // Realmを開こうとした時に、スキーマバージョンが異なれば自動的にマイグレーションが実行される
        _ = try! Realm()
    }
    
    func insertSeedData() {
        let csvArray = FileOperation.csvLoad(fileName: "initCSV")
        for csvStr in csvArray {
            let splitStr = csvStr.components(separatedBy: ",")
            let data = QustionData()
            data.major = splitStr[0]
            data.minor = splitStr[1]
            data.question = splitStr[2]
            data.answer = splitStr[3]
            data.save()
        }
        
    }
}

