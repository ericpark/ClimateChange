//
//  UIImage+Extension.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 9/5/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//

import Foundation
import UIKit.UIImage

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
