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
            autoreleasepool{
            do {
                //fetch names
                fetchRequest.predicate = NSPredicate(format: "name == %@", name)
                let results = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [DetailImages]
                if results.count != 0{
                    //let darkenedImage = UIImage(data: results[0].image! as Data)?.image(alpha: 0.7)
                    images[results[0].name! as String] = UIImage(data: results[0].image! as Data)?.image(alpha: 0.7)

                }
                managedContext.reset()

            
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            }
        }

        return images
    }
    
    /*
    func fetch(names: [String]) -> NSMutableDictionary{
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = (UIApplication.sharedApplication.delegate as! AppDelegate).persistentStoreCoordinator // or wherever your coordinator is
        
        managedObjectContext.perform { // runs asynchronously
            
            while(true) { // loop through each batch of inserts
                
                autoreleasepool {
                    let array: Array<MyManagedObject>? = getNextBatchOfObjects()
                    if array == nil { break }
                    for item in array! {
                        let newEntityObject = NSEntityDescription.insertNewObjectForEntityForName("MyEntity", inManagedObjectContext: managedObjectContext) as! MyManagedObject
                        newObject.attribute1 = item.whatever
                        newObject.attribute2 = item.whoever
                        newObject.attribute3 = item.whenever
                    }
                }
                
                // only save once per batch insert
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
                
                managedObjectContext.reset()
            }
        }
    }*/
    
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
