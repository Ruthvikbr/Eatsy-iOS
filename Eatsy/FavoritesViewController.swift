//
//  FavoritesViewController.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/24/25.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var FavoritesTableView: UITableView!
    
    var favoriteRecipes: [LocalRecipe] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        FavoritesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let recipes = LocalRecipe.getLocalRecipes(forKey: LocalRecipe.favoritesKey)
        self.favoriteRecipes = recipes
        FavoritesTableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesRecipeCell", for: indexPath) as! FavoritesRecipeCell
        let recipe = favoriteRecipes[indexPath.row]
        
        cell.RecipeNameLabel.text = recipe.recipe_name
        cell.configure(with: recipe, onFavoriteButtonTapped: { [weak self] recipe in
            recipe.removeFromFavorites()
            self?.refreshRecipes()
        })
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = FavoritesTableView.indexPathForSelectedRow else { return }

        let selectedRecipe = favoriteRecipes[selectedIndexPath.row]
        
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.localRecipe = selectedRecipe
        
    }
    
    private func refreshRecipes() {
        // 1.
        var recipes = LocalRecipe.getLocalRecipes(forKey: LocalRecipe.favoritesKey)
        self.favoriteRecipes = recipes
        FavoritesTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }


}
