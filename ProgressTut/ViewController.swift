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
    @IBOutlet weak var viewProg: UIView!
    
    
    var pepVotedForOneBox:Float = 0.0
    var totPepVoted: Float = 0.0
    var isRed = false
    var progressBarTimer: Timer!
    var isRunning = false
    
    let viewCornerRadius : CGFloat = 5
    var borderLayer : CAShapeLayer = CAShapeLayer()
    let progressLayer : CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressiveViewChanges()
        totalPeopleVoted.text = "1000"
        numOfPeopleVotedForOneBox.text = "555"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawProgressLayer()
    }
    
    func drawProgressLayer(){
        
        let bezierPath = UIBezierPath(roundedRect: viewProg.bounds, cornerRadius: viewCornerRadius)
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        borderLayer.fillColor = UIColor.black.cgColor
        borderLayer.strokeEnd = 0
        viewProg.layer.addSublayer(borderLayer)
        
        
    }
    
    //Make sure the value that you want in the function `rectProgress` that is going to define
    //the width of your progress bar must be in the range of
    // 0 <--> viewProg.bounds.width - 10 , reason why to keep the layer inside the view with some border left spare.
    //if you are receiving your progress values in 0.00 -- 1.00 range , just multiply your progress values to viewProg.bounds.width - 10 and send them as *incremented:* parameter in this func
    
    func rectProgress(incremented : CGFloat){
        
       // print("incremented = \(incremented)")
        if incremented <= viewProg.bounds.width - 10{
            progressLayer.removeFromSuperlayer()
            let rect = CGRect(x: 5, y: 5, width: incremented, height: viewProg.bounds.height - 10)
            let bezierPathProg = UIBezierPath(roundedRect: rect , cornerRadius: viewCornerRadius)
            bezierPathProg.close()
            
            progressLayer.path = bezierPathProg.cgPath
            progressLayer.fillColor = UIColor.white.cgColor
            borderLayer.addSublayer(self.progressLayer)
            
           
            
        }
        
    }
    
    //MARK: making progressive View changes
    func progressiveViewChanges() {
        progressView.progress = 0.0
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
        
//        let dividedNum = calcuForProgressView(inputNum: pepVotedForOneBox)
//        let width = viewProg.bounds.width
//        let incre = CGFloat(dividedNum) * ((width) - 10)
//        print(" incre = \(incre)😩")
//        // progressView.progress += dividedNum
//
//    //    UIView.animate(withDuration: 3) {
//            for i:CGFloat in stride(from: CGFloat(0), to: incre, by: 1) {
//                print("i = \(i)😄")
//
//                self.rectProgress(incremented: i)
//
//
//            }
//       // }
        
        
    }
    
    //MARK:  Set Timer for progressive Bar
    func setTimerForProgressiveBar() {
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(ViewController.updateProgressView), userInfo: nil, repeats: true)
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
   
    
    //MARK: To Get point number for the progress bae of scale 0.0 to 1.0
    func calcuForProgressView(inputNum: Float) -> Float {
        let newNum = inputNum / totPepVoted
        print("newNum = \(newNum)")
        return newNum
    }
    var incre: CGFloat = 0.0
    
    @objc func updateProgressView(){
        let dividedNum = calcuForProgressView(inputNum: pepVotedForOneBox)
        print("dividedNum = \(dividedNum)")
        
       
        
        UIView.animate(withDuration: 3, animations: { () -> Void in
         //   self.progressView.progress = dividedNum
            
            
            self.progressView.setProgress(dividedNum, animated: true)
        })
    
      
        if(progressView.progress == 1.0)
        {
            
            isRunning = false
            bnt.setTitle("Start", for: .normal)
        }
        
        let width = viewProg.bounds.width
        let newVal = CGFloat(dividedNum) * ((width) - 10)
        
        if incre <= CGFloat(newVal) {
            incre += 1
            print("Incre = \(incre)")
            self.rectProgress(incremented: incre)
        } else {
              progressBarTimer.invalidate()
        }
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    var increment: CGFloat = 0.0
    @IBAction func addAction(_ sender: Any) {
        increment += 1.0
        self.rectProgress(incremented: increment)
    }
    

}

