//
//  ViewController.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/23/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet weak var RecipeSearchTextField: UITextField!
    
    @IBOutlet weak var RecipeResultsView: UITableView!
    
    private var currentSearchText: String = ""
    private var searchTimer: Timer?
    private let delay: TimeInterval = 2.0
    
    private var recipes = [Recipe]()
    private var favorites = [LocalRecipe] ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        RecipeSearchTextField.delegate = self
        RecipeResultsView.dataSource = self
        favorites = LocalRecipe.getLocalRecipes(forKey: LocalRecipe.favoritesKey)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text, let textRange = Range(range, in: text) {
                currentSearchText = text.replacingCharacters(in: textRange, with: string)
            } else {
                currentSearchText = string
            }

            // Invalidate any existing timer
            searchTimer?.invalidate()

            // Schedule a new timer to call the API after the delay
            searchTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
                self?.callSearchAPI(query: self?.currentSearchText)
            }

            return true // Allow the text to change in the text field
        }
    
    private func callSearchAPI(query: String?) {
            guard let searchText = query, !searchText.isEmpty else {
                // Handle empty query (e.g., clear results)
                print("Search query is empty.")
                return
            }

        RecipeService.fetchRecipes(recipeName: searchText) { response in
            self.recipes = response.recipes
            self.RecipeResultsView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = RecipeResultsView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell

        let recipe = recipes[indexPath.row]
        
        cell.recipeName.text = recipe.recipe_name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = RecipeResultsView.indexPathForSelectedRow else { return }

        let selectedRecipe = recipes[selectedIndexPath.row]
        var localRecipe = LocalRecipe(id: selectedRecipe.id, recipe_name: selectedRecipe.recipe_name, ingredients: selectedRecipe.ingredients, instructions: selectedRecipe.instructions)
            
        if(favorites.contains(localRecipe)) {
            localRecipe.isFavorite = true
        }
        
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.localRecipe = localRecipe
        

    }
}

