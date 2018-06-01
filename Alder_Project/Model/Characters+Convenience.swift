//
//  Characters+Convenience.swift
//  Alder_Project
//
//  Created by Luis Puentes on 6/1/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import CoreData

extension Characters {
    
    @discardableResult convenience init(firstName: String?, lastName: String?, birthdate: String?, imageURL: String?, forceSensitive: Bool, affiliation: String?, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.profilePicture = imageURL
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let birthdate = dictionary["birthdate"] as? String,
            let imageURL = dictionary["profilePicture"] as? String,
            let forceSensitive = dictionary["forceSensitive"] as? Bool,
            let affiliation = dictionary["affiliation"] as? String else { return nil }
        
        self.init(firstName: firstName, lastName: lastName, birthdate: birthdate, imageURL: imageURL, forceSensitive: forceSensitive, affiliation: affiliation)
    }
}
