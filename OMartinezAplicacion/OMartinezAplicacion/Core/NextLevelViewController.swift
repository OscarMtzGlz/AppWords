//
//  NextLevelViewController.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 18/01/23.
//

import UIKit

class NextLevelViewController: UIViewController {
    
    var lett = ""
    var numeropalabras = 0
    var score = 0
    var intentos = 0
    
    let answers = [
        "score", "leter", "chest", "bares", "orcas", "renos", "viper", "dados", "cosas", "mouse", "tonos", "velas", "yogur", "zorro", "runas", "power", "ogros", "lunas", "hilos", "gafas"
    ]
    var answer = ""
    
    private var guesses : [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    let palabraVM = PalabraViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        answer = answers.randomElement() ?? "house"
        
        view.backgroundColor = UIColor(named: "Bg1")
        
        addAjustes()
        
        self.navigationController?.isNavigationBarHidden = true
        
        boardVC.scorelabel.text = "Score:"+String(score)
        
        let result = palabraVM.GetByPalabra(palabra: answer)
        if result.Correct {
            answer = answers.randomElement() ?? "llama"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        answer = answers.randomElement() ?? "hello"
    }
    
    private func addAjustes(){
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasource = self
        view.addSubview(boardVC.view)
        
        addConstraints()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
extension NextLevelViewController : KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        
        let alert = UIAlertController(title: "Game Over", message: "Te has quedado sin intentos", preferredStyle: .alert)
        let alertEnd = UIAlertController(title: "End Game", message: "Felicidades has ganado", preferredStyle: .alert)
        let alertnext = UIAlertController(title: "Has acertado", message: "Felicidades has encontrado la palabra", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default){(action) in
            self.performSegue(withIdentifier: "GameOver", sender: self)
        }
        let ok2 = UIAlertAction(title: "Ok", style: .default){(action) in
            self.performSegue(withIdentifier: "EndGame", sender: self)
        }
        let next = UIAlertAction(title: "Next", style: .default){(action) in
            self.performSegue(withIdentifier: "level", sender: self)
        }
        alert.addAction(ok)
        alertEnd.addAction(ok2)
        alertnext.addAction(next)
        
        lett = lett+""+String(letter)
        
        if lett == answer {
            score += 10
            numeropalabras += 1
            if score == 50 {
                self.present(alertEnd, animated: false)
            }else{
                let result = self.palabraVM.AddPalabra(palabra: self.answer)
                if result.Correct {
                    self.present(alertnext, animated: false)
                }
            }
        }
        if lett.count == 5 {
            print(answer)
            lett = ""
            intentos += 1
            boardVC.intentoslabel.text = "Intentos: \(String(intentos))/6"
            if intentos == 6{
                intentos = 0
                self.present(alert, animated: false)
            }
        }
        
        var stop = false
        
        for i in 0..<guesses.count{
            for j in 0..<guesses[i].count{
                if guesses[i][j] == nil{
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop{
                break
            }
        }
        boardVC.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "level" {
            let scorenext = segue.destination as! ViewController
            scorenext.score = self.score
            scorenext.numeropalabras = self.numeropalabras
        }
        if segue.identifier == "GaemOver"{
            let endview = segue.destination as! EndViewController
            endview.puntos = self.score
            endview.numeroPalabras = self.numeropalabras
        }
        if segue.identifier == "EndGame"{
            let endgame = segue.destination as! EndViewController
            endgame.puntos = self.score
            endgame.numeroPalabras = self.numeropalabras
        }
    }
}
extension NextLevelViewController : BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        
        let rowIndex = indexPath.section
        
        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else{
            return nil
        }
        
        let indexAnswer = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row], indexAnswer.contains(letter) else{
            return nil
        }
        
        if indexAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        
        return .systemOrange
    }
}
