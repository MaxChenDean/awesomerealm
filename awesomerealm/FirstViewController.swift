//
//  FirstViewController.swift
//  awesomerealm
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import RealmSwift


var list: [String] = [] //= ["plant", "run", "love him", "get chuck"]

var sorting: Bool = true
//true: priority
//false: date

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {

    @IBOutlet weak var mytableview: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    
    var filteredData = [String]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (isSearching) {
            return filteredData.count
        }

        return (list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if (isSearching) {
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell.textLabel?.text = filteredData[indexPath.row]
            return(cell)
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell.textLabel?.text = list[indexPath.row]
            return(cell)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil) || (searchBar.text == "") {
            isSearching = false
            view.endEditing(true)
            mytableview.reloadData()
            
        } else {
            isSearching = true
            filteredData = list.filter({$0 == searchBar.text})
            
            mytableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let realm = try! Realm()
            let todoList = realm.objects(todos.self)
            var check = 0
            for task in todoList {
                if (check == 1) {
                    break
                }
                if (task.name == list[indexPath.row]) {
                    try! realm.write
                {
                    realm.delete(task)
                    check = 1
                }
                }
            }
            list.remove(at: indexPath.row)
            mytableview.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mytableview.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

