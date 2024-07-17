//
//  UITableView+Cell.swift
//  Lesson13HW
//
//  Created by Pavel on 17.07.2024.
//

import UIKit

extension UITableView {
    
    func registerInfoCell () {
        
        let nib = UINib (nibName: "InfoCell", bundle: nil)
        
        register(nib, forCellReuseIdentifier: "InfoCell")
    }
    
    func registerFavoriteCell () {
        
        let nib = UINib (nibName: "FavoriteCell", bundle: nil)
        
        register(nib, forCellReuseIdentifier: "FavoriteCell")
    }
}
