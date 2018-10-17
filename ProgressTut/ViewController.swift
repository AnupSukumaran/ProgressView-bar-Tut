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
    
    var isRed = false
    var progressBarTimer: Timer!
    var isRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        progressiveViewChanges()
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
    var TotalNum:Float = 3000
    
    //MARK:
    func calcuForProgressView(inputNum: Float) -> Float {
        let newNum = inputNum / TotalNum
        print("newNum = newNum")
        return newNum
    }
    
    @objc func updateProgressView(){
        
        progressView.progress += 0.1
        UIView.animate(withDuration: 3, animations: { () -> Void in
            self.progressView.setProgress(1.0, animated: true)
        })
    
        if(progressView.progress == 1.0)
        {
            progressBarTimer.invalidate()
            isRunning = false
            bnt.setTitle("Start", for: .normal)
        }
    }
    


}

