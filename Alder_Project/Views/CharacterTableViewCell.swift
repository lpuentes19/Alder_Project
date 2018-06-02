//
//  CharacterTableViewCell.swift
//  Alder_Project
//
//  Created by Luis Puentes on 5/31/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func update(character: Characters) {
        guard let firstName = character.firstName,
            let lastName = character.lastName else { return }
        
        nameLabel.text = "\(firstName) \(lastName)"
    }
}
