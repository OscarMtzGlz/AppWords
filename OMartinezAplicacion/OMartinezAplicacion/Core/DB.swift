//
//  DB.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 24/01/23.
//

import Foundation
import SQLite3

class DB{
    let namedb : String = "WordlesBD.db"
    var db : OpaquePointer? = nil
    init(){
        db = OpenConexion(databaseName: namedb)
    }
    func OpenConexion(databaseName: String) -> OpaquePointer? {
        var databasePointer : OpaquePointer?
        let documentDatabasePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(databaseName).path
        if FileManager.default.fileExists(atPath: documentDatabasePath) {
            //print("Database exists")
        }else{
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else{
                //print("Unwrapping error: bundle path doesn't exists")
                return nil
            }
            do{
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                //print("Database created")
            }catch {
                print("Error")
                return nil
            }
        }
        if sqlite3_open(documentDatabasePath, &databasePointer) == SQLITE_OK {
            //print("Open database")
            //print(documentDatabasePath)
        }else{
            print("Could not open db")
        }
        
        return databasePointer
    }
}
