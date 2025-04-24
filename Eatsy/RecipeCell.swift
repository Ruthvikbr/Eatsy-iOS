//
//  RecipeCell.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/23/25.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeName: UILabel!
        
    var recipe:Recipe!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
