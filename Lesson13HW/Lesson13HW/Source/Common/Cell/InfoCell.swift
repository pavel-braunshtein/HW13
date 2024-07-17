//
//  InfoCell.swift
//  Lesson13HW
//
//  Created by Pavel on 17.07.2024.
//

import UIKit

class InfoCell: UITableViewCell {
    
    var isFavoriteAction: (() -> Void)?
    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var productСode: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productManufactured: UILabel!
    @IBOutlet weak var productModel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCurrency: UILabel!
    @IBOutlet weak var productIsFavoriteButton: UIButton!
    
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    @IBAction func isFavoritePressed(_ sender: Any) {
        
        isFavoriteAction?()
    }
    
}
