//
//  CategoryPageViewController.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 4/28/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//
import UIKit
import CoreData
import FirebaseDatabase
import FirebaseStorage

class CategoryPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var nameLabel: String!
    var imageNameLabel: String!
    var cellIdentifier = "CategoryPageTableViewCell"
    let cellSpacingHeight: CGFloat = 0
    
    var loadingIndicator: UIActivityIndicatorView!
    
    //Firebase
    var ref: FIRDatabaseReference!
    var topics: [String] = []
    lazy var images: NSMutableDictionary? = [:]
    lazy var topicDict: NSDictionary = [:]
    
    
    //Cache
    // let imageCache = NSCache<AnyObject, AnyObject>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.text = nameLabel
        headerImage.image = UIImage(named: imageNameLabel)
        
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width/2 - 25, y: UIScreen.main.bounds.height/2 - 25, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        loadingIndicator.startAnimating();
        
        self.view.addSubview(loadingIndicator)
        
        ref = FIRDatabase.database().reference()
        
        let childRef = FIRDatabase.database().reference(withPath: imageNameLabel)
        childRef.observe(.value, with: { snapshot in
            let a = snapshot.value as! NSDictionary
            self.topicDict = a
            self.topics = Array(self.topicDict.allKeys) as! [String]
            //Fetch using Document
            self.fetch(names: self.topics)
            self.loadImages()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.tableView.reloadData()
        //UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.images = [:]
        self.ref = nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImages(){
        self.tableView.isUserInteractionEnabled = false
        let taskGroup = DispatchGroup()
        // let alert = UIAlertController(title: nil, message: "Making the world a better place...", preferredStyle: .alert)
        
        //self.present(alert, animated: true)
        
        for (key, value) in topicDict{
            let dict = value as! NSDictionary
            let imageName = key as! String
            let keyExists = images?[key as Any] != nil
            if !keyExists{
                //print("Downloading")
                var fullImageName = dict["Image"] as! String
                fullImageName += "."
                fullImageName += dict["Filetype"] as! String
                let imageURL = FIRStorage.storage().reference(forURL: "gs://consequences-of-climate-change.appspot.com").child(fullImageName)
                taskGroup.enter()
                
                imageURL.downloadURL(completion: { (url, error) in
                    if error != nil {
                        //print(error?.localizedDescription as Any)
                        taskGroup.leave()
                        return
                    }
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            //print(error!)
                            taskGroup.leave()
                            return
                        }
                        
                        guard let imageData = UIImage(data: data!) else { return }
                        
                        DispatchQueue.main.async {
                            let key = imageName
                            let newImage = imageData as UIImage
                            let darkenedImage = newImage.image(alpha: 0.7)
                            self.images?[key] = darkenedImage
                            
                            self.save(name: imageName, image: newImage, type:dict["Filetype"] as! String, dateModified: NSDate())
                            
                            //print("Download Complete")
                            taskGroup.leave()
                            
                        }
                    }).resume()
                    
                })
                
                
            }
            
        }
        taskGroup.notify(queue: DispatchQueue.main){
            
            self.loadingIndicator.stopAnimating()
            self.tableView.reloadData()
            self.tableView.isUserInteractionEnabled = true
            
            URLCache.shared.removeAllCachedResponses()
            URLCache.shared.diskCapacity = 0
            URLCache.shared.memoryCapacity = 0
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    //tableview functions
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = topics.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CategoryPageTableViewCell
        cell.titleLabel.text = topics[indexPath.row]
        let key = topics[indexPath.row]
        if self.images?[key] != nil {
            cell.cellImageView!.image = self.images?[key]! as? UIImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = topics[indexPath.row]
        //ref = FIRDatabase.database().reference(withPath: key!)
        ref = FIRDatabase.database().reference()
        ref.observe(.value, with: { snapshot in
            if snapshot.hasChild(key){
                let keyRef = FIRDatabase.database().reference(withPath: key)
                keyRef.observe(.value, with: { snapshot in
                    let a = snapshot.value
                    if a is NSNull{
                        
                        self.pushEmptyViewController(indexPath: indexPath, desc: "Page under construction!")
                    }
                    else{
                        
                        let desc = (a as! NSDictionary)["Description"]
                        
                        
                        self.pushViewController(indexPath: indexPath, desc: desc as! String)
                        
                    }
                    
                })
            }
            else{
                self.pushEmptyViewController(indexPath: indexPath, desc: "Page under construction!")
            }
        })
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = UIScreen.main.bounds.size.height/9
        return height
    }
    
    func pushViewController(indexPath: IndexPath, desc: String){
        let vc = DetailPageViewController(nibName: "DetailPageViewController",bundle: nil)
        vc.detailName = topics[indexPath.row]
        
        var description = desc.replacingOccurrences(of:"_period", with:".")
        description = desc.replacingOccurrences(of:"_u", with:"_")
        description = desc.replacingOccurrences(of:"_q", with:"\"")
        description = desc.replacingOccurrences(of:"_sq", with:"\'")
        
        vc.text = description
        
        let key = topics[indexPath.row]
        let keyExists = (images?[key] != nil)
        if keyExists{
            vc.image = images?[key]! as? UIImage
        }
        else{
            vc.image = UIImage(named: "launch")
        }
        
        navigationController?.pushViewController(vc, animated: true )
    }
    
    func pushEmptyViewController(indexPath: IndexPath, desc: String){
        let vc = DetailPageViewController(
            nibName: "DetailPageViewController",
            bundle: nil)
        
        vc.detailName = topics[indexPath.row]
        vc.text = desc
        
        let key = topics[indexPath.row] as String
        let keyExists = (images?[key] != nil)
        if keyExists{
            vc.image = images?[key]! as? UIImage
        }
        else{
            vc.image = UIImage(named: "launch")
        }
        
        navigationController?.pushViewController(vc,animated: true )
    }
    
    func save(name: String, image: UIImage, type: String, dateModified: NSDate){
        let fileManager = FileManager.default
        //print(name)
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        //print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func fetch(names: [String]){
        let fileManager = FileManager.default
        var imagePath = ""
        for name in names{
            //print("fetching " + name)
            imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(name)
            if fileManager.fileExists(atPath: imagePath){
                self.images?[name] = UIImage(contentsOfFile: imagePath)
                //print("Success " + name)

            }else{
                //print("No Image")
            }

        }
    }
    
    
    /* Core Data Fetch
    //Problem: Fetching Core data = Lots of memory = Crash = :(
 
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
    
    */

    
    /* Core Data Save
     //Problem: Saving to core data caused memory spikes to crash the program
    func save(name: String, image: UIImage, type: String, dateModified: NSDate)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DetailImages", in: managedContext)!
        let detailImage = NSManagedObject(entity: entity, insertInto: managedContext)
        var imageData: NSData
        let type_lower = type.lowercased()
        if type_lower == "jpg" || type_lower == "jpeg"{
            imageData = NSData(data: UIImageJPEGRepresentation(image, 0.0)!)
        }
        else{
            imageData = NSData(data: UIImagePNGRepresentation(image)!)
            
        }
        
        detailImage.setValue(name, forKeyPath: "name")
        detailImage.setValue(imageData, forKeyPath: "image")
        detailImage.setValue(dateModified, forKeyPath: "dateModified")
        detailImage.setValue(type_lower, forKeyPath:"filetype")
        
        do {
            try managedContext.save()
        } catch _ as NSError {
            //print("Could not save. \(error), \(error.userInfo)")
        }
    }*/
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
