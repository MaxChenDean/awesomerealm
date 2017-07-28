//
//  SecondViewController.swift
//  awesomerealm
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import RealmSwift

var check = 0

class SecondViewController: UIViewController {
    
    @IBOutlet weak var priorityvalue: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var mydatepicker: UIDatePicker!

    @IBOutlet weak var input: UITextField!

    var datep: Date {
        get{
            return mydatepicker.date
        }
    }

    
    @IBAction func additem(_ sender: UIButton) {
        
        if (input.text != ""){
           // list.append(input.text!)
            
            //add to realm
            let newone = todos()
            if (priorityvalue.text != ""){
                newone.priority = Int(priorityvalue.text!)!
            } else {
                newone.priority = 0
            }
            newone.name = input.text!
            newone.planneddate = mydatepicker.date
            
            let realm = try! Realm()
            
            if (check < 1) {
                try! realm.write {
                    realm.deleteAll()
                }
                check += 1
            }
            
            try! realm.write {
                realm.add(newone)
            }
            queryTodos()
            
            input.text = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

