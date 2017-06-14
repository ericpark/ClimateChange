//
//  HomeViewController.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 4/26/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class HomeViewController: MenuContainerViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuViewController = self.storyboard!.instantiateViewController(withIdentifier: "NavigationMenu") as! MenuViewController
        
        contentViewControllers = contentControllers()
        
        selectContentViewController(contentViewControllers.first!)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        //self.navigationController?.setNavigationBarHidden(false, animated: animated);
        
        
    }
    
    override func menuTransitionOptionsBuilder() -> TransitionOptionsBuilder? {
        return TransitionOptionsBuilder() { builder in
            builder.duration = 0.5
            builder.contentScale = 1
        }
    }
    
    private func contentControllers() -> [MenuItemContentViewController] {
        var contentList = [MenuItemContentViewController]()
        
        contentList.append( HomePageViewController(nibName: "HomePageViewController", bundle: nil) as MenuItemContentViewController)
        contentList.append( BiographyPageViewController(nibName: "BiographyPageViewController", bundle: nil) as MenuItemContentViewController)
        contentList.append( AboutPageViewController(nibName: "AboutPageViewController", bundle: nil) as MenuItemContentViewController)

        return contentList
    }
}

