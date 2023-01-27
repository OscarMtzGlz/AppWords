//
//  EndViewController.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 24/01/23.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var Palabraslbl: UILabel!
    @IBOutlet weak var Puntoslbl: UILabel!
    @IBOutlet weak var Aceptarbtn: UIButton!
    
    var puntos : Int = 0
    var numeroPalabras : Int = 0
    var rankingViewModel = RankingViewModel()
    let palabraVM = PalabraViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Bg1")
        self.navigationController?.isNavigationBarHidden = true
        Palabraslbl.text = String(numeroPalabras)
        Puntoslbl.text = String(puntos)
        // Do any additional setup after loading the view.
        
        let result = palabraVM.DeletePalabras()
    }

    @IBAction func Actionbtn(_ sender: UIButton) {
        var ranking = Ranking()
        ranking.NumeroPalabras = self.numeroPalabras
        ranking.Score = self.puntos
        let result = rankingViewModel.Add(ranking: ranking)
        if result.Correct {
            self.performSegue(withIdentifier: "EndSegue", sender: self)
        }
    }
}
