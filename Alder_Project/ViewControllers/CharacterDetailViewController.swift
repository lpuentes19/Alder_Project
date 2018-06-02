//
//  CharacterDetailViewController.swift
//  Alder_Project
//
//  Created by Luis Puentes on 6/1/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var forceSensitiveLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    var character: Characters? {
        didSet {
            DispatchQueue.main.async {
                self.update()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    func update() {
        guard let character = character,
            let firstName = character.firstName,
            let lastName = character.lastName,
            let birthdate = character.birthdate,
            let affiliation = character.affiliation else { return }
        
        nameLabel.text = "\(firstName) \(lastName)"
        birthdateLabel.text = "Birthdate: \(birthdate)"
        forceSensitiveLabel.text = "Force Sensitive: \(character.forceSensitive)"
        affiliationLabel.text = "Affiliation: \(affiliation)"
        
        if let imageURL = character.profilePicture {
            DispatchQueue.main.async {
                self.characterImage.sd_setImage(with: URL(string: imageURL))
                self.characterImage.layer.masksToBounds = false
                self.characterImage.layer.cornerRadius = 5
                self.characterImage.clipsToBounds = true
            }
        }
    }
}
