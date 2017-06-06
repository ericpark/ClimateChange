//
//  DetailImages+CoreDataProperties.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 5/10/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//

import Foundation
import CoreData


extension DetailImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailImages> {
        return NSFetchRequest<DetailImages>(entityName: "DetailImages");
    }

    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var dateModified: NSDate?
    @NSManaged public var filetype: String?

}
