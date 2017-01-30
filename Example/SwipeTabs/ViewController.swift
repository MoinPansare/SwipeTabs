//
//  ViewController.swift
//  SwipeTabs
//
//  Created by MoinPansare on 01/30/2017.
//  Copyright (c) 2017 MoinPansare. All rights reserved.
//

import UIKit
import SwipeTabs

class ViewController: UIViewController {

    @IBOutlet weak var snowView: UIView!
    var tabBar : SwipeTabContainer = SwipeTabContainer();
    var tabBarHeight : CGFloat = 65;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let snowBackground : SnowEffect = SnowEffect();
        self.snowView.addSubview(snowBackground.loadbackground(parent_frame: self.view.frame, image: UIImage(named: "bg")!));
        addtabs();
    }
    
    func addtabs() -> Void {
        tabBar.setFrameForMainView(frame: CGRect(x: 0, y: self.view.frame.size.height - tabBarHeight, width: self.view.frame.size.width, height: tabBarHeight));
        
        tabBar.setBackgroundColor(color: UIColor.init(red: 111.0/255.0, green: 94.0/255.0, blue: 124.0/255.0, alpha: 1.0))
        
        var list : [TabStr] = [TabStr]();
        
        for i in 0...3{
            let str : TabStr = TabStr();
            switch i {
            case 0 : str.color = UIColor.init(red: 235.0/255.0, green: 98.0/255.0, blue: 94.0/255.0, alpha: 1.0);
            str.imageName = "cool";break;
            case 1 : str.color = UIColor.init(red: 237.0/255.0, green: 183.0/255.0, blue: 129.0/255.0, alpha: 1.0);
            str.imageName = "hat";break;
            case 2 : str.color = UIColor.init(red: 111.0/255.0, green: 174.0/255.0, blue: 203.0/255.0, alpha: 1.0);
            str.imageName = "love";break;
            case 3 : str.color = UIColor.init(red: 235.0/255.0, green: 109.0/255.0, blue: 154.0/255.0, alpha: 1.0);
            str.imageName = "smile";break;
            default : str.color = UIColor.init(red: 235.0/255.0, green: 98.0/255.0, blue: 94.0/255.0, alpha: 1.0);
            }
            list.append(str);
        }
        
        tabBar.loadTabData(list: list);
        tabBar.loadtabsFromList();
        
        let view : UIView = tabBar.getMainView();
        self.view.addSubview(view);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBar.tabList[tabBar.currrentSelection].performSelection()
    }

    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
}

