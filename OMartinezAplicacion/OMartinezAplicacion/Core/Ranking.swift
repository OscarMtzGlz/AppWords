//
//  Ranking.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 24/01/23.
//

import Foundation

struct Ranking{
    var IdRanking : Int
    var NumeroPalabras : Int
    var Score : Int
    
    init(IdRanking: Int, NumeroPalabras: Int, Score: Int) {
        self.IdRanking = IdRanking
        self.NumeroPalabras = NumeroPalabras
        self.Score = Score
    }
    
    init(){
        self.IdRanking = 0
        self.NumeroPalabras = 0
        self.Score = 0
    }
}
