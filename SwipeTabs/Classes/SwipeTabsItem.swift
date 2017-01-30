//
//  SwipeTabsItem.swift
//  Pods
//
//  Created by Moin on 30/01/17.
//
//

import UIKit

import UIKit

public class SwipeTabsItem: UIView {
    
    var myIndex : Int = 0;
    var imageScalingFactor : CGFloat = 10;
    var myProtocol : MySwipeTabItemProtocol?;
    
    @IBOutlet var mainVIew: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var animatingView: UIView!
    @IBOutlet weak var tabImage: UIImageView!
    @IBOutlet weak var myButton: UIButton!
    
    
    var animatinfViewLeftFrame : CGRect? = nil;
    var animatinfViewRightFrame : CGRect? = nil;
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
//        UINib(nibName: "SwipeTabsItem", bundle: nil).instantiate(withOwner: self, options: nil)
        
        
        
        UINib(nibName: "SwipeTabsItem", bundle: Bundle.init(for: SwipeTabsItem.self)).instantiate(withOwner: self, options: nil)
        addSubview(mainVIew);
        mainVIew.frame = self.bounds;
        
    }
    
    @IBAction func mySelectionButtonClicked(_ sender: Any) {
        myProtocol?.buttonClicked(index: myIndex);
    }
    
    public func performSelection() {
        self.animateToTopFromLeft(duration: 1.5, delay: 0.0);
    }
    
    
    public func loadAnimatinView() -> Void {
        self.animatingView.frame = CGRect(x: 0, y: 0, width: 0, height: self.containerView.frame.size.height);
    }
    
    public func setData(myStr : TabStr) -> Void {
        self.animatingView.backgroundColor = myStr.color;
        self.tabImage.image = UIImage(named: myStr.imageName);
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "SwipeTabsItem", bundle: Bundle.init(for: SwipeTabsItem.self)).instantiate(withOwner: self, options: nil)
        addSubview(mainVIew);
        mainVIew.frame = self.bounds;
        loadAnimatinView();
    }
    
    public func animateToTopFromLeft(duration : Float,delay : Float) -> Void {
        self.animatingView.frame = CGRect(x: 0, y: 0, width: 0, height: self.containerView.frame.size.height);
        
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.imageSelectionAnimation();
            self.animatingView.frame = self.containerView.frame;
        }, completion: nil)
    }
    
    public func animateToTopFromRight(duration : Float,delay : Float) -> Void {
        self.animatingView.frame = CGRect(x: self.containerView.frame.size.width, y: 0, width: 0, height: self.containerView.frame.size.height);
        
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.imageSelectionAnimation();
            self.animatingView.frame = self.containerView.frame;
        }, completion: nil)
    }
    
    public func DeSelectAnimationToRight(duration : Float, delay : Float) -> Void {
        self.imageDeSelectionAnimation();
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.animatingView.frame = CGRect(x: self.containerView.frame.size.width, y: 0, width: 0, height: self.containerView.frame.size.height)
        }, completion: nil)
    }
    
    public func DeSelectAnimationToLeft(duration : Float, delay : Float) -> Void {
        self.imageDeSelectionAnimation();
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.animatingView.frame = CGRect(x: 0, y: 0, width: 0, height: self.containerView.frame.size.height)
        }, completion: nil)
    }
    
    public func performPassByAnimationFromLeft(duration : Float, delay : Float) -> Void {
        let duration2 : Float = duration / 2;
        self.animatingView.frame = CGRect(x: 0, y: 0, width: 0, height: self.containerView.frame.size.height);
        
        let internal_duration = duration - (duration / 10);
        
        UIView.animate(withDuration: TimeInterval(internal_duration), delay: TimeInterval(delay), options: .curveLinear, animations: {
            self.animatingView.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
        }, completion: {
            (value: Bool) in
            self.runCompletionAnimation1(duration: duration2)
        })
        
    }
    
    public func runCompletionAnimation1(duration : Float) -> Void {
        let duration1 = duration * 2;
        UIView.animate(withDuration: TimeInterval(duration1), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.animatingView.frame = CGRect(x: self.containerView.frame.size.width, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
        }, completion: nil)
        
    }
    
    public func performPassByAnimationFromRight(duration : Float, delay : Float) -> Void {
        let duration2 : Float = duration / 2;
        self.animatingView.frame = CGRect(x: self.containerView.frame.size.width, y: 0, width: 0, height: self.containerView.frame.size.height);
        
        let internal_duration = duration - (duration / 10);
        
        UIView.animate(withDuration: TimeInterval(internal_duration), delay: TimeInterval(delay), options: .curveLinear, animations: {
            self.animatingView.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height);
        }, completion: {
            (value: Bool) in
            self.runCompletionAnimation2(duration: duration2)
        })
    }
    
    public func runCompletionAnimation2(duration : Float) -> Void {
        let duration1 = duration * 2;
        UIView.animate(withDuration: TimeInterval(duration1), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.animatingView.frame = CGRect(x: 0, y: 0, width: 0, height: self.containerView.frame.size.height);
        }, completion: nil)
        
    }
    
    public func imageSelectionAnimation() -> Void {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.tabImage.frame = CGRect(x: self.tabImage.frame.origin.x - self.imageScalingFactor, y: self.tabImage.frame.origin.y - self.imageScalingFactor, width: self.tabImage.frame.size.width + (2 * self.imageScalingFactor) , height: self.tabImage.frame.size.height + (2 * self.imageScalingFactor))
        }, completion: nil)
    }
    
    public func imageDeSelectionAnimation() -> Void {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.tabImage.frame = CGRect(x: self.tabImage.frame.origin.x + self.imageScalingFactor, y: self.tabImage.frame.origin.y + self.imageScalingFactor, width: self.tabImage.frame.size.width - (2 * self.imageScalingFactor) , height: self.tabImage.frame.size.height - (2 * self.imageScalingFactor))
        }, completion: nil)
    }
    
}

public protocol MySwipeTabItemProtocol : NSObjectProtocol {
    func buttonClicked(index: Int) -> Void
}

public class TabStr: NSObject {
    public var imageName : String = "";
    public var labelText : String = "";
    public var color : UIColor?;
}
