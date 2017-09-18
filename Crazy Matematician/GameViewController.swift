//
//  GameViewController.swift
//  Crazy Matematician
//
//  Created by Yerbolat Beisenbek on 18.09.17.
//  Copyright © 2017 Yerbolat Beisenbek. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!

    
    var timer: Timer!
    
    var timeLeft: Int = 11
    var firstNumber: Int!
    var secondNumber: Int!
    var operation: Int!
    var answer: Int!
    var sign: String = "asd"
    var points: Int = 0
    var highscore: Int = 0
    var lives: Int = 3
    
    @objc func updateCounting(){
        timeLeft -= 1
        timerLabel.text = "00:" + String(timeLeft)
        if timeLeft == 0 {
            updateProblem()
        }
    }
    
    func updateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounting), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateProblem()
        self.updateTimer()
        
        let highscoreDefault = UserDefaults.standard
        if highscoreDefault.value(forKey: "highscore") != nil {
            highscore = highscoreDefault.value(forKey: "highscore") as! Int
            highscoreLabel.text = "Highscore: " + String(highscore)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if answerField.text == String(answer) {
            points += 100
            scoreLabel.text = String(points)
            
            if points > highscore {
                highscore = points
                
                let highscoreDefault = UserDefaults.standard
                highscoreDefault.set(highscore, forKey: "highscore")
                highscoreDefault.synchronize()
                
            }
            
            updateProblem()
        }else{
            updateProblem()
        }
    }
    
    func returnRandomNumber() -> Int{
        let random = Int(arc4random_uniform(UInt32(10)))
        return random
    }
    
    func returnRandomOperation() -> Int{
        let random = Int(arc4random_uniform(UInt32(4)))
        return random
    }
    
    func updateProblem(){
        timeLeft = 16
        answerField.text = ""
        
        firstNumber = returnRandomNumber()
        secondNumber = returnRandomNumber()
        operation = returnRandomOperation()
        
        switch operation {
        case 1:
            answer = firstNumber + secondNumber
            sign = "+"
        case 2:
            answer = firstNumber - secondNumber
            sign = "-"
        case 3:
            answer = firstNumber * secondNumber
            sign = "*"
        case 4:
            answer = firstNumber / secondNumber
            sign = "/"
        default:
            answer = firstNumber + secondNumber
            sign = "+"
        }
        
        problemLabel.text = String(firstNumber) + sign + String(secondNumber)
        
    }

}
