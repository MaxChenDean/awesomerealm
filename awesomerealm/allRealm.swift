//
//  allRealm.swift
//  awesomerealm
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
import RealmSwift

class todos: Object {
    dynamic var priority: Int = 0
    dynamic var planneddate = Date(timeIntervalSince1970: 1)
    dynamic var name = ""
    
}

func queryTodos() {
    let realm = try! Realm()
    let todoList = realm.objects(todos.self)
 
    let resultList = todoList.sorted(byKeyPath: "priority", ascending: false)
    list.removeAll()
    for task in resultList {
      //  print(task.name)
        list.append(task.name)
    }
}
