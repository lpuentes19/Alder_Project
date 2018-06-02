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
    
    // Storing the Dictionary Keys in constants
    fileprivate static let kFirstName = "firstName"
    fileprivate static let kLastName = "lastName"
    fileprivate static let kBirthdate = "birthdate"
    fileprivate static let kProfilePicture = "profilePicture"
    fileprivate static let kForceSensitive = "forceSensitive"
    fileprivate static let kAffiliation = "affiliation"
    
    @discardableResult convenience init(firstName: String?, lastName: String?, birthdate: String?, imageURL: String?, forceSensitive: Bool, affiliation: String?, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.profilePicture = imageURL
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
    }
    // Failable initializer that takes in the CharacterDictionary we get back from the server
    convenience init?(dictionary: [String: Any]) {
        guard let firstName = dictionary[Characters.kFirstName] as? String,
            let lastName = dictionary[Characters.kLastName] as? String,
            let birthdate = dictionary[Characters.kBirthdate] as? String,
            let imageURL = dictionary[Characters.kProfilePicture] as? String,
            let forceSensitive = dictionary[Characters.kForceSensitive] as? Bool,
            let affiliation = dictionary[Characters.kAffiliation] as? String else { return nil }
        
        self.init(firstName: firstName, lastName: lastName, birthdate: birthdate, imageURL: imageURL, forceSensitive: forceSensitive, affiliation: affiliation)
        
        // Creating objects and saving the data we receive to Core Data
        CharacterController.shared.createCharacters(firstName: firstName, lastName: lastName, birthdate: birthdate, imageURL: imageURL, forceSensitive: forceSensitive, affiliation: affiliation)
    }
}
