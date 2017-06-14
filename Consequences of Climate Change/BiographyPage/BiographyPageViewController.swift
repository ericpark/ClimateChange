//
//  BiographyPageViewController.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 6/14/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//
import UIKit
import InteractiveSideMenu


class BiographyPageViewController: MenuItemContentViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didOpenMenu(_ sender: UIButton) {
        showMenu()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
