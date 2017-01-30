//
//  SnowEffect.swift
//  SwipeTabs
//
//  Created by Moin on 30/01/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//


import Foundation
import UIKit

class SnowEffect: NSObject {
    
    var contentsScale : CGFloat = 12.0;
    var birthRate : CGFloat = 5.0;
    
    var lifetime : CGFloat = 50;
    var velocity : CGFloat = 50;
    
    var emissionLongitude : CGFloat = CGFloat.pi;
    var emissionRange : CGFloat = CGFloat.pi / 4;
    
    var spin : CGFloat = 0.9;
    var spinRange : CGFloat = 1.2;
    
    var scaleRange : CGFloat = -0.05;
    var contentsImage : UIImage = UIImage();
    
    override init() {
        super.init();
        self.contentsImage = UIImage(named: "snow")!;
    }
    
    func loadbackground(parent_frame : CGRect,image : UIImage) -> UIView {
        
        let tempFrame : CGRect = CGRect(x: parent_frame.origin.x - 50, y: parent_frame.origin.y - 50, width: parent_frame.size.width + 100, height: parent_frame.size.height + 100)
        
        let transparency_view : UIView = UIView(frame: CGRect(x: parent_frame.origin.x - 100, y: parent_frame.origin.y - 100, width: parent_frame.size.width * 2, height: parent_frame.size.height * 2))
        
        transparency_view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        let view = UIImageView(frame: tempFrame)
        view.contentMode = UIViewContentMode.scaleAspectFill
        view.image = image
        view.addSubview(transparency_view);
        
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        let flake = makeEmitterCell()
        cloud.emitterCells = [flake]
        view.layer.addSublayer(cloud)
        
        applyMotionEffect(toView: view, magnitude: 30)
        
        return view;
    }
    
    func applyMotionEffect (toView view:UIView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = self.contentsScale
        cell.birthRate = Float(self.birthRate)
        cell.lifetime = Float(self.lifetime)
        cell.velocity = self.velocity
        cell.emissionLongitude = self.emissionLongitude
        cell.emissionRange = self.emissionRange
        cell.spin = self.spin
        cell.spinRange = self.spinRange
        cell.scaleRange = self.scaleRange
        cell.contents = self.contentsImage.cgImage
        return cell
    }
    
    
    
}
