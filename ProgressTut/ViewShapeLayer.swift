//
//  ViewShapeLayer.swift
//  ProgressTut
//
//  Created by Abraham VG on 19/10/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit

class ViewShapeLayer: UIView {
    
    let viewCornerRadius : CGFloat = 5
    var borderLayer : CAShapeLayer = CAShapeLayer()
    let progressLayer : CAShapeLayer = CAShapeLayer()
   

    func drawProgressLayer(view: UIView){
        
        let bezierPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: viewCornerRadius)
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        borderLayer.fillColor = UIColor.black.cgColor
        borderLayer.strokeEnd = 0
        view.layer.addSublayer(borderLayer)
        
        
    }

}
