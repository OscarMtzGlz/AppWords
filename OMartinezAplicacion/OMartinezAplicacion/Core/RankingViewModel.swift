//
//  RankingViewModel.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 24/01/23.
//

import Foundation
import SQLite3

class RankingViewModel{
    func Add(ranking : Ranking) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Ranking(NumeroPalabras,Score) VALUES (?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_int(statement, 1, Int32(ranking.NumeroPalabras))
                sqlite3_bind_int(statement, 2, Int32(ranking.Score))
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func GetAll() -> Result {
        var result = Result()
        let context = DB.init()
        let query = "SELECT NumeroPalabras, Score FROM Ranking"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var ranking = Ranking()
                    ranking.NumeroPalabras = Int(sqlite3_column_int(statement, 0))
                    ranking.Score = Int(sqlite3_column_int(statement, 1))
                    
                    result.Objects?.append(ranking)
                }
                result.Correct = true
            }else{
                result.Correct = false
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    func Delete() -> Result {
        var result = Result()
        let context = DB.init()
        let query = "DELETE FROM Ranking"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}
