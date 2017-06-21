//
//  HomePageViewController.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 4/28/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreData

class HomePageViewController: MenuItemContentViewController {

    
    //var images: NSMutableDictionary = [:]
    var buttonPushed: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch()
        buttonPushed = false
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        buttonPushed = false
        super.viewDidDisappear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didOpenMenu(_ sender: UIButton) {
        showMenu()
    }

    //TODO: This should all be done in prepare. 
    @IBAction func healthMenu(_ sender: UIButton) {
        if !buttonPushed{
            buttonPushed = true
            let vc = CategoryPageViewController(
                nibName: "CategoryPageViewController",
                bundle: nil)
            //vc.images = images
            vc.nameLabel = "Effects on Human Health"
            vc.imageNameLabel = "Health"
            navigationController?.pushViewController(vc,
                                                     animated: true )

        }
    }
    
    @IBAction func economyMenu(_ sender: UIButton) {
        if !buttonPushed{
            buttonPushed = true
            let vc = CategoryPageViewController(
                nibName: "CategoryPageViewController",
                bundle: nil)
            //vc.images = images
            vc.nameLabel = "Effects on the Economy"
            vc.imageNameLabel = "Economy"
            navigationController?.pushViewController(vc,
                                                     animated: true )
        }
    }
    
    @IBAction func societyMenu(_ sender: UIButton) {
        if !buttonPushed{
            buttonPushed = true
            let vc = CategoryPageViewController(
                nibName: "CategoryPageViewController",
                bundle: nil)
            //vc.images = images
            vc.nameLabel = "Effects on Society"
            vc.imageNameLabel = "Society"
            navigationController?.pushViewController(vc,
                                                     animated: true )
        }
    }
    
    @IBAction func wildlifeMenu(_ sender: UIButton) {
        if !buttonPushed{
            buttonPushed = true
            let vc = CategoryPageViewController(
                nibName: "CategoryPageViewController",
                bundle: nil)
            //vc.images = images
            vc.nameLabel = "Effects on Wildlife"
            vc.imageNameLabel = "Wildlife"
            navigationController?.pushViewController(vc,
                                                     animated: true )
        }
    }
    
    @IBAction func naturalMenu(_ sender: UIButton) {
        if !buttonPushed{
            buttonPushed = true
            let vc = CategoryPageViewController(
                nibName: "CategoryPageViewController",
                bundle: nil)
            //vc.images = images
            vc.nameLabel = "Effects on Natural Systems"
            vc.imageNameLabel = "Natural Systems"
            
            navigationController?.pushViewController(vc,
                                                     animated: true )

        }
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

extension UIViewController{
    
}

extension UIImage {
    //Increase Alpha to make it transparent. This will be used to darken image over black bg
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
