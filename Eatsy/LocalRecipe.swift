//
//  LocalRecipe.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/24/25.
//

import Foundation

struct LocalRecipe: Codable, Equatable {
    let id: Int
    let recipe_name: String
    let ingredients: [String]
    let instructions: [String]
    var isFavorite: Bool = false
}

extension LocalRecipe {
    static var favoritesKey: String {
        return "Favorites"
    }
    
    static func save(_ localRecipes: [LocalRecipe], forKey key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(localRecipes)
        defaults.set(encodedData, forKey: key)
    }
    
    static func getLocalRecipes(forKey key: String) -> [LocalRecipe] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            let decodedLocalRecipes = try! JSONDecoder().decode([LocalRecipe].self, from: data)
            return decodedLocalRecipes
        } else {
            return []
        }
    }
    
    func addToFavorites() {
        var favoriteRecipes = LocalRecipe.getLocalRecipes(forKey: LocalRecipe.favoritesKey)
        favoriteRecipes.append(self)
        LocalRecipe.save(favoriteRecipes, forKey: LocalRecipe.favoritesKey)
    }
    
    func removeFromFavorites() {
        var favoriteRecipes = LocalRecipe.getLocalRecipes(forKey: LocalRecipe.favoritesKey)
        favoriteRecipes.removeAll { localRecipe in
            return self == localRecipe
        }
        LocalRecipe.save(favoriteRecipes, forKey: LocalRecipe.favoritesKey)
    }
}
