//
//  DBHelper.swift
//  DevSQLite
//
//  Created by SD-M004 on 26/4/2564 BE.
//

import Foundation
import SQLite3

class DBHelper {
    
    init() {
        db = openDatabase()
        createTable()
    }
    
    let dbPath:String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
//        var db: OpaquePointer? = nil
        
        if  sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        } else {
            print("Successfully opened conntection to database at \(dbPath)")
            return db
        }
        
    }
    
    func createTable() {
        
        let createTableString = "CREATE TABLE IF NOT EXISTS person(id INTEGER PRIMARY KEY AUTOINCREMENT,firstName varchar(50),lastName varchar(50), age INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
        
    }
    
    func read() -> [Person] {
        
        let queryStatementString = "SELECT * FROM person;"
        var queryStatement: OpaquePointer? = nil
        var psns: [Person] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(queryStatement, 0)
                let firstName  = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let lastName  = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let year = sqlite3_column_int(queryStatement, 3)
                
//                psns.append(Person(_firstName: firstName, _lastName: lastName, _age: Int(year)))
                psns.append(Person(_id: Int(id), _firstName: firstName, _lastName: lastName, _age: Int(year)))
                print("Query Result:")
                print("\(id) | \(firstName) | \(lastName) | \(year)")
                
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return psns
        
    }
    
    
    func insertData(firstNane:String, lastName:String, age:Int) {
        
//        let persons = read()
//        for p in persons
//        {
//            if p.id == id
//            {
//                return
//            }
//        }
        
        let insertStatementString = "INSERT INTO person (firstName, lastName, age) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (firstNane as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (lastName as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(age))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
            
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
        
    }
    
    func deleteByID(id:Int) {
        
        let deleteStatementString = "DELETE FROM person WHERE id = ?"
        var deleteStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
            
        } else {
            print("DELETE statement coule not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)
        
    }
    
    
}
