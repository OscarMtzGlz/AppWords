//
//  PlayViewController.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 20/01/23.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var PlayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Bg1")
        PlayButton.layer.cornerRadius = 50
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ActionPlay(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Play", sender: self)
    }
    
    @IBAction func RankingAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TablaSegue", sender: self)
    }
}
