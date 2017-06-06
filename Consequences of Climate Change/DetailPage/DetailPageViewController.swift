//
//  DetailPageViewController.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 4/28/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var detailName:String!
    var text:String!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = detailName
        textView.text = text
        textView.isEditable = false
        if image != nil{
            imageView.image = image.image(alpha: 1.0)
            imageView.tintColor = UIColor.black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
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

