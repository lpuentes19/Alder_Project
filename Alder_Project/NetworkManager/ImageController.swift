//
//  ImageController.swift
//  Alder_Project
//
//  Created by Luis Puentes on 5/31/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static func image(forURL url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { fatalError("Image URL optional is nil") }
        
        NetworkController.performRequest(for: url, httpMethod: .get) { (data, error) in
            guard let data = data,
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async { completion(nil) }
                    return
            }
            
            DispatchQueue.main.async { completion(image) }
        }
    }
}
