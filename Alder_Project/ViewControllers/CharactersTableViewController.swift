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
    
    // This was a property used to take in and display the content recieved from the server initially before storing data locally
    var characters = [Characters?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Deleting the records in the Characters class using NSBatchRequest so that we can check for any updates and then save the new data we receive to NSPersistent Store
        CharacterController.shared.delete()
        
        // Function checks to see if the data is stored locally, if not then it makes the network call, saves the data locally and then retrieves it from Core Data and displays it
        loadAllCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    // Network call if you did not want to use the data that is stored in Core Data
    func loadAllCharacters() {
        if CharacterController.shared.characters.count == 0 {
            CharacterController.shared.fetchCharacters { (characters) in
                self.characters = characters
            }
        } else {
            print("Already saved data.")
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
