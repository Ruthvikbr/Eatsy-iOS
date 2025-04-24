//
//  Recipe.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/23/25.
//

import Foundation

struct Recipe: Codable, Equatable {
    let id: Int
    let recipe_name: String
    let ingredients: [String]
    let instructions: [String]
}

struct RecipeListResponse: Decodable {
    let recipes: Array<Recipe>
}

extension Recipe {    
    static var recipeKey: String {
        return "Recipes"
    }
    static func save(_ recipes: [Recipe]) {

        let defaults = UserDefaults.standard
        let encodedRecipes = try! JSONEncoder().encode(recipes)
        defaults.set(encodedRecipes, forKey: recipeKey)
    }
    
    static func getRecipes() -> [Recipe] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: recipeKey) {
            let decodedRecipes = try! JSONDecoder().decode([Recipe].self, from: data)
            return decodedRecipes
        } else {
            return []
        }
    }
    
    func save() {
        var allRecipes = Recipe.getRecipes()
        if let recipeIndex = allRecipes.firstIndex(where: {$0.id == self.id}) {
            allRecipes.remove(at: recipeIndex)
            allRecipes.insert( self, at: recipeIndex)
        } else {
            allRecipes.append(self)
        }
        
        Recipe.save(allRecipes)
    }
}
