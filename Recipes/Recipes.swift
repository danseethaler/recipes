//
//  Recipes.swift
//  Recipes
//
//  Created by Dan Seethaler on 4/4/16.
//  Copyright © 2016 Dan Seethaler. All rights reserved.
//

import Foundation
import Alamofire

class Recipes {
    
    var recipes = [Recipe]()
    
    let recipesUrl:String! = "https://dev.esafesite.com/apps/userlitestoreapps/recipes/v999/json/recipes.htp"
    
    func loadRecipes(recipesLoadedCallback: ([Recipe]) -> ()) {
        Alamofire.request(.GET, recipesUrl, parameters: ["limit": "5"])
            .responseJSON { response in
                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let recipesList = response.result.value {
                    
                    for recipe in recipesList as! [Dictionary<String, AnyObject>] {
                        
                        let imageURLString:String = recipe["imageURL"] as! String
                        
                        let imageUrlVal = NSURL(string: imageURLString)
                        
                        let recipeTitle = recipe["title"] as! String
                        
                        let recipeOb = Recipe(title: recipeTitle, imageURL: imageUrlVal!)
                        
                        self.recipes.append(recipeOb)
                        
                    }
                    
                }
                
                recipesLoadedCallback(self.recipes)
                
        }
    }
    
    
}