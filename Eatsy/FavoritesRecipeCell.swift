//
//  FavoritesRecipeCell.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/24/25.
//

import UIKit

class FavoritesRecipeCell: UITableViewCell {
    
    @IBOutlet weak var RecipeNameLabel: UILabel!
    
    @IBOutlet weak var FavoriteButton: UIButton!
    
    var onFavoriteButtonTapped: ((LocalRecipe) -> Void)?
    
    var recipe: LocalRecipe!

    @IBAction func didFavoriteButtonTapped(_ sender: UIButton) {
        recipe.isFavorite = false
        onFavoriteButtonTapped?(recipe)
    }
    
    func configure(with recipe: LocalRecipe, onFavoriteButtonTapped: ((LocalRecipe) -> Void)?) {
        self.recipe = recipe
        self.onFavoriteButtonTapped = onFavoriteButtonTapped
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
