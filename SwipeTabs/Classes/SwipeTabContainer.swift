//
//  SwipeTabContainer.swift
//  Pods
//
//  Created by Moin on 30/01/17.
//
//
import UIKit

public class SwipeTabContainer: NSObject,MySwipeTabItemProtocol {
    
    public var mainView : UIView = UIView();
    public var myData : [TabStr] = [TabStr]();
    public var tabList : [SwipeTabsItem] = [SwipeTabsItem]();
    var animationDuration : Float = 1.5;
    
    private var cellWidth : CGFloat = 0;
    private var cellHeight : CGFloat = 0;
    
    public var currrentSelection : Int = -1;
    
    public override init() {
        super.init();
    }
    
    public func setFrameForMainView(frame : CGRect) -> Void {
        self.mainView.frame = frame;
    }
    
    public func getMainView() -> UIView {
        return self.mainView;
    }
    
    public func loadTabData(list : [TabStr]) -> Void {
        self.myData = list;
        self.cellHeight = self.mainView.frame.size.height;
        self.cellWidth = self.mainView.layer.frame.size.width / CGFloat(list.count);
    }
    
    public func loadtabsFromList() -> Void {
        tabList.removeAll();
        for i in 0..<self.myData.count{
            let leftPosition : CGFloat = CGFloat(i) * cellWidth;
            let cell : SwipeTabsItem = SwipeTabsItem();
            cell.myIndex = i;
            cell.frame = CGRect(x: leftPosition - 1, y: 0, width: cellWidth + 2, height: cellHeight);
            self.mainView.addSubview(cell)
            cell.myProtocol = self;
            tabList.append(cell);
            cell.setData(myStr: self.myData[i]);
            if currrentSelection == -1 {
                currrentSelection = i;
            }
            
        }
    }
    
    public func setBackgroundColor(color : UIColor){
        self.mainView.backgroundColor = color;
    }
    
    public func buttonClicked(index: Int) {
        var diff : Int = 0;
        
        if index == currrentSelection {
            return;
        }
        
        diff = abs (currrentSelection - index);
        
        if index > currrentSelection {
            if diff == 1 {
                tabList[currrentSelection].DeSelectAnimationToRight(duration: animationDuration, delay: 0.0);
                tabList[index].animateToTopFromLeft(duration: animationDuration, delay: 0.0);
            }else{
                let newDuration = Double(animationDuration) / Double(diff + 1)
                tabList[currrentSelection].DeSelectAnimationToRight(duration: Float(newDuration), delay: 0.0);
                var myPosition = 0;
                for i in (currrentSelection + 1)..<index{
                    
                    let timeConstant = self.getDelay(newDuration: newDuration, myPosition: Double(myPosition));
                    
                    tabList[i].performPassByAnimationFromLeft(duration : Float(newDuration),delay : timeConstant);
                    myPosition += 1;
                }
                let timeConstant = self.getDelay(newDuration: newDuration, myPosition: Double(myPosition));
                tabList[index].animateToTopFromLeft(duration: Float(newDuration), delay: timeConstant);
            }
        }else{
            if diff == 1 {
                tabList[currrentSelection].DeSelectAnimationToLeft(duration: animationDuration, delay: 0.0);
                tabList[index].animateToTopFromRight(duration: animationDuration, delay: 0.0);
            }else{
                
                let newDuration = Double(animationDuration) / Double(diff + 1)
                tabList[currrentSelection].DeSelectAnimationToLeft(duration: Float(newDuration), delay: 0.0);
                var myPosition = 0;
                var i = currrentSelection - 1;
                while i > index {
                    
                    let timeConstant = self.getDelay(newDuration: newDuration, myPosition: Double(myPosition));
                    
                    tabList[i].performPassByAnimationFromRight(duration : Float(newDuration),delay : timeConstant);
                    myPosition += 1;
                    i = i - 1;
                }
                let timeConstant = self.getDelay(newDuration: newDuration, myPosition: Double(myPosition));
                tabList[index].animateToTopFromRight(duration: Float(newDuration), delay: timeConstant);
            }
        }
        
        currrentSelection = index;
        
    }
    
    private func getDelay(newDuration : Double , myPosition : Double) -> Float {
        return Float(newDuration * myPosition);
    }
    
}
