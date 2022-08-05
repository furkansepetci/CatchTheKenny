//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Furkan Sepetci on 25.07.2022.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var hideTimer = Timer()
    var counter = 20
    var hideCounter = 40
    var score = 0
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScoreKey")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score: 0"
        }else{
            highScore = storedHighScore as? Int ?? 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
            
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCounterFunction), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func counterFunction (){
        timeLabel.text = "Time: \(counter)"
        counter-=1
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = "Time: \(counter)"
            let alert = UIAlertController(title: "Time's Up", message: "Do U Want to Play Again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.hideCounter = 20
                self.timeLabel.text = "Time: \(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counterFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideCounterFunction), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            if score > highScore{
                highScore = score
                highScoreLabel.text = "New High Score: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScoreKey")
            }
        }
    }
    
    
    @objc func hideCounterFunction (){
        let randomNumber = Int.random(in: 1...9)
        let imageViewArray = [imageView1,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9]
        
        for image in imageViewArray {
            image?.isHidden = true
            image?.isUserInteractionEnabled = true
        }

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        imageView1.addGestureRecognizer(recognizer1)
        imageView2.addGestureRecognizer(recognizer2)
        imageView3.addGestureRecognizer(recognizer3)
        imageView4.addGestureRecognizer(recognizer4)
        imageView5.addGestureRecognizer(recognizer5)
        imageView6.addGestureRecognizer(recognizer6)
        imageView7.addGestureRecognizer(recognizer7)
        imageView8.addGestureRecognizer(recognizer8)
        imageView9.addGestureRecognizer(recognizer9)
        
        imageViewArray[randomNumber-1]?.isHidden = false
        hideCounter-=1
        
        if hideCounter == 0 {
            for image in imageViewArray {
                image?.isHidden = true
                hideTimer.invalidate()
            }
        }
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
}


