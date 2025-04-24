//
//  RecipeService.swift
//  Eatsy
//
//  Created by Ruthvik Ravi on 4/23/25.
//
import Foundation


class RecipeService {
    static func fetchRecipes(recipeName:String, completion: ((RecipeListResponse) -> Void)? = nil) {
        let parameters = "dishName=\(recipeName)"
        let url = URL(string: "http://10.0.0.122:3000/auth/recipes?\(parameters)")!
        let task = URLSession.shared
            .dataTask(with: url) {data,response,error in
                guard error == nil else {
                    assertionFailure("Error: \(error!.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    assertionFailure("Invalid response")
                    return
                }
                guard let data = data,
                      httpResponse.statusCode == 200 else {
                    assertionFailure(
                        "Invalid response status code: \(httpResponse.statusCode)"
                    )
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let recipeListResponse = try decoder.decode(RecipeListResponse.self, from: data)
                    DispatchQueue.main.async {
                                    completion?(recipeListResponse)
                                }
                } catch {
                    print("Error decoding JSON: \(error)")
                    // Handle the error appropriately, e.g., show an error message to the user
                }
                
            }
         task.resume()
    }
    
}
       

