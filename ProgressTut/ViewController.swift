//
//  ViewController.swift
//  ProgressTut
//
//  Created by Abraham VG on 17/10/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var bnt: UIButton!
    
    @IBOutlet weak var totalPeopleVoted: UITextField!
    
    @IBOutlet weak var numOfPeopleVotedForOneBox: UITextField!
    
    
    var pepVotedForOneBox:Float = 0.0
    var totPepVoted: Float = 0.0
    var isRed = false
    var progressBarTimer: Timer!
    var isRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        progressiveViewChanges()
        totalPeopleVoted.text = "1000"
        numOfPeopleVotedForOneBox.text = "555"
    }
    
    //MARK: making progressive View changes
    func progressiveViewChanges() {
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 57)
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
    }
    
    @IBAction func bnt(_ sender: Any) {
        
        totPepVoted = Float(totalPeopleVoted.text ?? "0.0") ?? 0.0
        pepVotedForOneBox = Float(numOfPeopleVotedForOneBox.text ?? "0.0") ?? 0.0
        print("totPepVoted = \(totPepVoted)")
        print("pepVotedForOneBox = \(pepVotedForOneBox)")
        
        if isRunning {
          progressBarTimer.invalidate()
          bnt.setTitle("Start", for: .normal)
        } else {
            bnt.setTitle("Stop", for: .normal)
            progressView.progress = 0.0
            setTimerForProgressiveBar()
        }
        
        changedBarColor()
        isRunning = !isRunning
    }
    
    //MARK:  Set Timer for progressive Bar
    func setTimerForProgressiveBar() {
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateProgressView), userInfo: nil, repeats: true)
    }
    
    
    func changedBarColor() {
        if(isRed){
            progressView.progressTintColor = UIColor.blue
            progressView.progressViewStyle = .default
        } else{
            progressView.progressTintColor = UIColor.red
            progressView.progressViewStyle = .bar
        }
    }
   
    
    //MARK:
    func calcuForProgressView(inputNum: Float) -> Float {
        let newNum = inputNum / totPepVoted
        print("newNum = \(newNum)")
        return newNum
    }
    
    @objc func updateProgressView(){
        let dividedNum = calcuForProgressView(inputNum: pepVotedForOneBox)
        print("dividedNum = \(dividedNum)")
       // progressView.progress += dividedNum
        UIView.animate(withDuration: 3, animations: { () -> Void in
         //   self.progressView.progress = dividedNum
            self.progressView.setProgress(dividedNum, animated: true)
        })
    
        if(progressView.progress == 1.0)
        {
            progressBarTimer.invalidate()
            isRunning = false
            bnt.setTitle("Start", for: .normal)
        }
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    


}

