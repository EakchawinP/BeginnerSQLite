//
//  ViewController.swift
//  DevSQLite
//
//  Created by SD-M004 on 26/4/2564 BE.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tf_FirstName: UITextField!
    @IBOutlet weak var tf_LastName: UITextField!
    @IBOutlet weak var tf_Age: UITextField!
    @IBOutlet weak var btn_Save: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var db:DBHelper = DBHelper()
    var persons:[Person] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //MARK:- Register Nib
        self.tableView.register(ItemCellTableViewCell.nib(), forCellReuseIdentifier: ItemCellTableViewCell.identify)
        
        self.readData()
                
    }
    
    
    func setLayout() {
        
        bgView.backgroundColor = .white
        bgView.layer.borderColor = UIColor(red: 249, green: 249, blue: 249, alpha: 1).cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.shadowOpacity = 0.2
        bgView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        bgView.layer.shadowRadius = 2
        bgView.layer.cornerRadius = 15.0
        
        btn_Save.layer.cornerRadius = 10.0
        
    }

    func readData() {
        
        self.persons = db.read()
        
        self.tableView.reloadData()
        
    }
    
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        let firstName:String = self.tf_FirstName.text!
        let lastName:String = self.tf_LastName.text!
        let age:Int = Int(self.tf_Age.text!)!
        
        self.db.insertData(firstNane: firstName, lastName: lastName, age: age)
//        self.tableView.reloadData()
        self.readData()
    
    }
    
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCellTableViewCell.identify, for: indexPath) as! ItemCellTableViewCell
        
        cell.lb_FirstName.text = "\(self.persons[indexPath.row].firstName) \(self.persons[indexPath.row].lastName)"
        
        return cell
        
    }
    
    
}
