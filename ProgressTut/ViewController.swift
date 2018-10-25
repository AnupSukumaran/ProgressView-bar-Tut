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
//    @IBOutlet weak var viewProg: UIView!
//    @IBOutlet weak var viewProg1: UIView!
    
    @IBOutlet var viewsCollec: [UIView]!
    
    @IBOutlet var labels: [UILabel]!
//    @IBOutlet weak var labelTest: UILabel!
//    @IBOutlet weak var label1Test: UILabel!
    
    var pepVotedForOneBox:Float = 0.0
    var totPepVoted: Float = 0.0
    var isRed = false
    var progressBarTimer: Timer!
    var isRunning = false
    
    let viewCornerRadius : CGFloat = 5
//    var borderLayer : CAShapeLayer = CAShapeLayer()
//    let progressLayer : CAShapeLayer = CAShapeLayer()
//    var borderLayer1 : CAShapeLayer = CAShapeLayer()
//    let progressLayer1 : CAShapeLayer = CAShapeLayer()
    var borderLayers: [CAShapeLayer] = [CAShapeLayer(), CAShapeLayer()]
    let progressLayers: [CAShapeLayer] = [CAShapeLayer(), CAShapeLayer()]
    override func viewDidLoad() {
        super.viewDidLoad()
        progressiveViewChanges()
        totalPeopleVoted.text = "1000"
        numOfPeopleVotedForOneBox.text = "555"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //drawProgressLayer()
        for i in 0..<viewsCollec.count {
            drawProgressLayer(index: i)
        }
    }
    
    func drawProgressLayer(index: Int){
        
        let bezierPath = UIBezierPath(roundedRect: viewsCollec[index].bounds, cornerRadius: viewCornerRadius)
        bezierPath.close()
        
        borderLayers[index].path = bezierPath.cgPath
        borderLayers[index].fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        borderLayers[index].strokeEnd = 0
        viewsCollec[index].layer.addSublayer(borderLayers[index])
        viewsCollec[index].bringSubviewToFront(labels[0])
        
       
        
    }
    
//    func drawProgressLayer(){
//
//        let bezierPath = UIBezierPath(roundedRect: viewProg.bounds, cornerRadius: viewCornerRadius)
//        bezierPath.close()
//
//        borderLayer.path = bezierPath.cgPath
//        borderLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//        borderLayer.strokeEnd = 0
//        viewProg.layer.addSublayer(borderLayer)
//        viewProg.bringSubviewToFront(labelTest)
//
//        let bezierPath1 = UIBezierPath(roundedRect: viewProg1.bounds, cornerRadius: viewCornerRadius)
//        bezierPath1.close()
//
//        borderLayer1.path = bezierPath1.cgPath
//        borderLayer1.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//        borderLayer1.strokeEnd = 0
//        viewProg1.layer.addSublayer(borderLayer1)
//        viewProg1.bringSubviewToFront(label1Test)
//
//    }
    
    //Make sure the value that you want in the function `rectProgress` that is going to define
    //the width of your progress bar must be in the range of
    // 0 <--> viewProg.bounds.width - 10 , reason why to keep the layer inside the view with some border left spare.
    //if you are receiving your progress values in 0.00 -- 1.00 range , just multiply your progress values to viewProg.bounds.width - 10 and send them as *incremented:* parameter in this func
    
    
    func rectProgress(incremented : CGFloat, index: Int){
        
        // print("incremented = \(incremented)")
        if incremented <= viewsCollec[index].bounds.width - 10{
            progressLayers[index].removeFromSuperlayer()
            let rect = CGRect(x: 5, y: 5, width: incremented, height: viewsCollec[index].bounds.height - 10)
            let bezierPathProg = UIBezierPath(roundedRect: rect , cornerRadius: viewCornerRadius)
            bezierPathProg.close()
            
        
            progressLayers[index].path = bezierPathProg.cgPath
            progressLayers[index].fillColor = UIColor.white.cgColor
            borderLayers[index].addSublayer(progressLayers[index])
            
        
            
            
        }
        
    }
    
//    func rectProgress(incremented : CGFloat){
//
//       // print("incremented = \(incremented)")
//        if incremented <= viewProg.bounds.width - 10{
//            progressLayer.removeFromSuperlayer()
//            let rect = CGRect(x: 5, y: 5, width: incremented, height: viewProg.bounds.height - 10)
//            let bezierPathProg = UIBezierPath(roundedRect: rect , cornerRadius: viewCornerRadius)
//            bezierPathProg.close()
//
//            let rect1 = CGRect(x: 5, y: 5, width: incremented, height: viewProg1.bounds.height - 10)
//            let bezierPathProg1 = UIBezierPath(roundedRect: rect1 , cornerRadius: viewCornerRadius)
//            bezierPathProg1.close()
//
//            progressLayer.path = bezierPathProg.cgPath
//            progressLayer.fillColor = UIColor.white.cgColor
//            borderLayer.addSublayer(self.progressLayer)
//
//            progressLayer1.path = bezierPathProg1.cgPath
//            progressLayer1.fillColor = UIColor.white.cgColor
//            borderLayer1.addSublayer(self.progressLayer1)
//
//
//        }
//
//    }
    
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
   
    
    //MARK: To Get point number for the progress bar of scale 0.0 to 1.0
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
        
        let width = viewsCollec[0].bounds.width
        let newVal = CGFloat(dividedNum) * ((width) - 10)
        
        if incre <= CGFloat(newVal) {
            incre += 1
            print("Incre = \(incre)")
            self.rectProgress(incremented: incre, index: 0)
            self.rectProgress(incremented: incre, index: 1)
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
      //  self.rectProgress(incremented: increment)
    }
    

}

