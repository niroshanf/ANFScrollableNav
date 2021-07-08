//
//  StandaloneNavViewController.swift
//  ANFScrollableNav
//
//  Created by anthony-fernandez on 07/08/2021.
//  Copyright © 2021 Anthony Niroshan Fernandez. All rights reserved.
//

import UIKit
import ANFScrollableNav

class StandaloneNavViewController: UIViewController {

    @IBOutlet var navContainerEN: UIView!
    @IBOutlet var navContainerAR: UIView!

    var navigationEN: NavigationManager!
    var navigationAR: NavigationManager!

    var colors = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.gray, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.darkGray, UIColor.magenta, UIColor.purple]
    
    
    let menuItemsEn = ["Home", "World", "Politics", "Business", "Sports", "Variety", "Programs", "Entertainment", "Style", "Videos"]
    let menuItemsAr = ["منزل، بيت", "عالم", "سياسة", "اعمال", "رياضات", "متنوع", "البرامج", "وسائل الترفيه", "أسلوب", "أشرطة فيديو "]
    
    var direction: UISemanticContentAttribute = .forceLeftToRight
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation English
        self.navigationEN = NavigationManager(name: "EnNav", items: self.menuItemsEn, delegate: self, UIDelegate: self, container: self.navContainerEN, orientation: .forceLeftToRight, standaloneNavigation: true)
        self.navigationEN.addNavigation(positionOnContainer: .Bottom, constant: -10.0)
        
        //Navigation Arabic
        self.navigationAR = NavigationManager(name: "ARNav", items: self.menuItemsAr, delegate: self, UIDelegate: self, container: self.navContainerAR, orientation: .forceRightToLeft, standaloneNavigation: true)
        self.navigationAR.addNavigation(positionOnContainer: .Bottom, constant: -10.0)
    }
    
}

extension StandaloneNavViewController: NavigationManagerDelegate {
    
    func menuItemClicked(selectedIndex: Int, manager: NavigationManager) {
        
        if manager == self.navigationEN{
            //Change the indicator color
            if let indicator = self.navigationEN.getIndicatorView() as? MenuIndicatorRoundedEdge {
                indicator.setIndicatorColor(color: self.colors[selectedIndex])
            }
        }
        else if manager == self.navigationAR {
            //Change the indicator color
            if let indicator = self.navigationAR.getIndicatorView() as? MenuIndicatorRoundedEdge {
                indicator.setIndicatorColor(color: self.colors[selectedIndex])
            }
        }

        print("menu clicked = \(selectedIndex)")
    }
    
    func selectedMenu(menuItem: String, manager: NavigationManager) -> NSAttributedString {
    
        let color: UIColor = UIColor(named: "SelectedMenu")!
        let font = UIFont.boldSystemFont(ofSize: 16)
        return NSMutableAttributedString(string: menuItem, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color])
    }
    
    func unselectedMenu(menuItem: String, manager: NavigationManager) -> NSAttributedString {
        let color: UIColor = UIColor(named: "UnselectedMenu")!
        let font = UIFont.boldSystemFont(ofSize: 16)
        return NSMutableAttributedString(string: menuItem, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color])
    }
}


extension StandaloneNavViewController: NavigationManagerUIDelegate {
    
    func interItemSpacing() -> CGFloat {
        return 24.0
    }
    
    func contentInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 0, bottom: 10, right: 0)
    }
    
    func indicatorView(selectedIndex: Int) -> UIView {
        let v = MenuIndicatorRoundedEdge()
        v.backgroundColor = UIColor.clear
        v.indicatorColor = colors[selectedIndex]

        return v
    }
    
    func indicatorHeight() -> CGFloat {
        return 4.0
    }
    
    func menuHeight() -> CGFloat {
        return 50.0
    }
}

