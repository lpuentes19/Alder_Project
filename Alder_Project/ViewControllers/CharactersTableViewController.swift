//
//  CharactersTableViewController.swift
//  Alder_Project
//
//  Created by Luis Puentes on 5/31/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    var characters = [Characters?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllCharacters()
    }

    func loadAllCharacters() {
        CharacterController.shared.fetchCharacters { (characters) in
            self.characters = characters
        }
    }
    
    func getImage(for character: Characters, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = character.profilePicture else { return }
        ImageController.image(forURL: imageURL, completion: completion)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharacterController.shared.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }

        if let character = characters[indexPath.row] {
    
            cell.update(character: character)
            
            getImage(for: character) { (image) in
                DispatchQueue.main.async {
                    cell.characterImage.image = image
                }
            }
        }
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? CharacterDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.character = characters[indexPath.row]
        }
    }
}
