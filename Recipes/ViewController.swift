//
//  ViewController.swift
//  Recipes
//
//  Created by Dan Seethaler on 4/2/16.
//  Copyright © 2016 Dan Seethaler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var inSearchMode = false
    var recipesEnum = Recipes();
    
    @IBAction func refreshRecipesData() {
        
        recipesEnum.loadRecipes(recipesDownloaded)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        
//        parseRecipesCsv()
        
    }
    
    func recipesDownloaded(recipesList: [Recipe]) -> () {
        
        for recipe in recipesList {
            recipes.append(recipe)
        }
        
        collection.reloadData()

    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercaseString
            filteredRecipes = recipes.filter({$0.title.rangeOfString(lower) != nil})
            
        }
        
        collection.reloadData()
        
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as? RecipeCell {
            
            let recipe: Recipe!
            
            if inSearchMode {
                recipe = filteredRecipes[indexPath.row]
            }else {
                recipe = recipes[indexPath.row]
            }
            
            let img: UIImage? = RecipeCell.imageCache.objectForKey(recipe.imageURL) as? UIImage
            
            cell.configureCell(recipe, img: img)
            
            return cell
            
        }else {
            
            return UICollectionViewCell()
            
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        print(recipes[indexPath.row].directions)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredRecipes.count
        }
        
        return recipes.count
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(180, 180)
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }


}

