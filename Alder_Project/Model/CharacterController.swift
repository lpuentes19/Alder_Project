//
//  CharacterController.swift
//  Alder_Project
//
//  Created by Luis Puentes on 5/31/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import CoreData

class CharacterController {
    
    static let shared = CharacterController()
    
    var characters: [Characters] {
        return fetchIndividuals()
    }
    
    let baseURL: URL? = URL(string: "https://starwarstest16.herokuapp.com/api/characters")
    

    func fetchCharacters(completion: @escaping ([Characters]) -> Void) {
        
        guard let url = baseURL else { return }
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: nil, body: nil) { (data, error) in
            if error != nil {
                print("There was an error receiving the data. Error: \(String(describing: error))")
            } else {
                guard let data = data,
                    let jsonRepresentation = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let charactersDictionary = jsonRepresentation["individuals"] as? [[String: Any]] else {
                        print("Unable to serialize JSON.")
                        return
                }
                
                let results = charactersDictionary.compactMap { Characters(dictionary: $0) }
                completion(results)
                print(results)
            }
        }
    }
    // Create and save the object to the NSManaged Object Context
    func createCharacters(firstName: String, lastName: String, birthdate: String, imageURL: String, forceSensitive: Bool, affiliation: String) {
        let _ = Characters(firstName: firstName, lastName: lastName, birthdate: birthdate, imageURL: imageURL, forceSensitive: forceSensitive, affiliation: affiliation)
        saveToPersistentStorage()
    }
    // Deleting the object from the persistent store and saving the changes
    func delete(character: Characters) {
        let moc = CoreDataStack.context
        moc.delete(character)
        
        saveToPersistentStorage()
    }
    // Fetching the saved objects from the persistent store
    func fetchIndividuals() -> [Characters] {
        let request: NSFetchRequest<Characters> = Characters.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    // Saving the objects and storing them in a persistent store
    func saveToPersistentStorage() {
        (try? CoreDataStack.context.save())
    }
}








