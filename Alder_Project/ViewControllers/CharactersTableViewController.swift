//
//  CharactersTableViewController.swift
//  Alder_Project
//
//  Created by Luis Puentes on 5/31/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import SDWebImage

class CharactersTableViewController: UITableViewController {

    // Stored the cellIdentifier in a constant
    fileprivate let cellIdentifier = "characterCell"
    
    // This was a property used to take in and display the content recieved from the server
    var characters = [Characters?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Not calling this function because we've already stored the data, no need to keep calling it.
        //loadAllCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    // Network call if you did not want to use the data that is stored in Core Data
    func loadAllCharacters() {
        CharacterController.shared.fetchCharacters { (characters) in
            self.characters = characters
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharacterController.shared.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        
        let character = CharacterController.shared.characters[indexPath.row]
        
        if let imageURL = character.profilePicture {
            cell.update(character: character)
            
            // Making sure we go back on the main thread when updating the UI
            DispatchQueue.main.async {
                cell.characterImage.sd_setImage(with: URL(string: imageURL))
                cell.characterImage.layer.masksToBounds = false
                cell.characterImage.layer.cornerRadius = cell.characterImage.frame.height/2
                cell.characterImage.clipsToBounds = true
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? CharacterDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.character = CharacterController.shared.characters[indexPath.row]
        }
    }
}
