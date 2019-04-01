//
//  QustionData.swift
//  Moment-English-composition
//
//  Created by 信次　智史 on 2019/03/31.
//  Copyright © 2019 stoshi nobutsugu. All rights reserved.
//

import Foundation
import RealmSwift

class QustionData: Object {
    @objc dynamic var sortNum = 0
    @objc dynamic var major = ""
    @objc dynamic var minor = ""
    @objc dynamic var question = ""
    @objc dynamic var answer = ""
    
    // majorにインデックスを貼る
    override static func indexedProperties() -> [String] {
        return ["major"]
    }
    
    func save() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {
            print("realm Err")
        }
    }
    
    @objc static func distinctByMajor() -> [String] {
        let realm = try! Realm()
        
        let distinctMajors = Set(realm.objects(QustionData.self).value(forKey: "major") as! [String])
        return Array(distinctMajors)
    }
    
    static func getDatasByMajor(majorKey: String) -> Results<QustionData> {
        let realm = try! Realm()
        
        let distinctMajors = realm.objects(QustionData.self).filter("major==%@", majorKey)
        return distinctMajors
    }
}
