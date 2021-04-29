//
//  Person.swift
//  DevSQLite
//
//  Created by SD-M004 on 26/4/2564 BE.
//

import Foundation

class Person {
    
    var id:Int = 0
    var firstName:String = ""
    var lastName:String = ""
    var age:Int = 0
    
    init(_id:Int, _firstName:String, _lastName:String, _age:Int) {
        self.id = _id
        self.firstName = _firstName
        self.lastName = _lastName
        self.age = _age
    }
    
}
