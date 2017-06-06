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

    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didOpenMenu(_ sender: UIButton) {
        showMenu()
    }

    @IBAction func healthMenu(_ sender: UIButton) {
        let vc = CategoryPageViewController(
            nibName: "CategoryPageViewController",
            bundle: nil)
        //vc.images = images
        vc.nameLabel = "Effects on Human Health"
        vc.imageNameLabel = "Health"
        navigationController?.pushViewController(vc,
                                                 animated: true )
    }
    
    @IBAction func economyMenu(_ sender: UIButton) {
        let vc = CategoryPageViewController(
            nibName: "CategoryPageViewController",
            bundle: nil)
        //vc.images = images
        vc.nameLabel = "Effects on the Economy"
        vc.imageNameLabel = "Economy"
        navigationController?.pushViewController(vc,
                                                 animated: true )
    }
    
    @IBAction func societyMenu(_ sender: UIButton) {
        let vc = CategoryPageViewController(
            nibName: "CategoryPageViewController",
            bundle: nil)
        //vc.images = images
        vc.nameLabel = "Effects on Society"
        vc.imageNameLabel = "Society"
        navigationController?.pushViewController(vc,
                                                 animated: true )
    }
    
    @IBAction func wildlifeMenu(_ sender: UIButton) {
        let vc = CategoryPageViewController(
            nibName: "CategoryPageViewController",
            bundle: nil)
        //vc.images = images
        vc.nameLabel = "Effects on Wildlife"
        vc.imageNameLabel = "Wildlife"
        navigationController?.pushViewController(vc,
                                                 animated: true )
    }
    
    @IBAction func naturalMenu(_ sender: UIButton) {
        //print("Pushing to natural")

        let vc = CategoryPageViewController(
            nibName: "CategoryPageViewController",
            bundle: nil)
        //vc.images = images
        vc.nameLabel = "Effects on Natural Systems"
        vc.imageNameLabel = "Natural Systems"
        
        navigationController?.pushViewController(vc,
                                                 animated: true )
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
    func fetch(names: [String]) -> NSMutableDictionary{
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return [:]
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "DetailImages")

        let images: NSMutableDictionary = [:]
        
        for name in names{
             do {
                fetchRequest.predicate = NSPredicate(format: "name == %@", name)
                let results = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [DetailImages]
                if results.count != 0{
                    let darkenedImage = UIImage(data: results[0].image! as Data)?.image(alpha: 0.7)
                    //let darkenedImage = UIImage(data: results[0].image! as Data)
                    images[results[0].name! as String] = darkenedImage
                    ////print("adding " + results[0].name! as String)

                }
                
            //let fetchedImages = try managedContext.fetch(fetchRequest) as! [DetailImages]
            //let array = fetchedImages
            
            
           // for image in array{
             //
               // let darkenedImage = UIImage(data: image.image! as Data)?.image(alpha: 0.7)
                //images[image.name! as String] = darkenedImage
                ////print("adding " + image.name! as String)
                //let storageRef = FIRStorage.storage().reference()
                //let imageRef = storageRef.child(image.name! + "." + image.filetype!)
                
                // Get metadata properties
                /*
                 imageRef.metadata { metadata, error in
                 if let error = error {
                 // Uh-oh, an error occurred!
                 // //print(error)
                 } else {
                 // Metadata now contains the metadata for 'images/forest.jpg'
                 if (metadata?.updated)?.compare(image.dateModified as! Date) == ComparisonResult.orderedDescending {
                 managedContext.delete(image)
                 }
                 }
                 }*/
           // }
            managedContext.reset()
            
            
            } catch _ as NSError {
                //print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return images
    }
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
