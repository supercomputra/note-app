//
//  Note.swift
//  Notes
//
//  Created by Zulwiyoza Putra on 10/29/16.
//  Copyright © 2016 Zulwiyoza Putra. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Note: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var modificationTime: Date?
    convenience init() {
        let appDelegate =   UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
        self.init(entity: entity!, insertInto: managedContext)
    }
}
