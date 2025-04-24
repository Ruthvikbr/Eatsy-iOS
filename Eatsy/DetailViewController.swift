//
//  DetailViewController.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/24/25.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    @IBOutlet weak var instructionsTableView: UITableView!
    
    private var instructions = [String]()
    private var ingredients = [String]()
    
    @IBOutlet weak var favoriteButton: UIButton!
    var localRecipe:LocalRecipe!
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            localRecipe.addToFavorites()
        } else {
            localRecipe.removeFromFavorites()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        instructionsTableView.dataSource = self
        
        recipeNameLabel.text = localRecipe.recipe_name
        instructions =  localRecipe.instructions
        ingredients = localRecipe.ingredients
        
        let favorites = LocalRecipe.getLocalRecipes(forKey: LocalRecipe.favoritesKey)
        if favorites.contains(localRecipe) {
            favoriteButton.isSelected = true
        } else {
            favoriteButton.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag == 0) {
            return ingredients.count
        } else {
            return instructions.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0

        if(tableView.tag == 0) {
            cell.textLabel?.text = ingredients[indexPath.row]
        } else {
            cell.textLabel?.text = instructions[indexPath.row]
        }
        
        return cell
    }

}
