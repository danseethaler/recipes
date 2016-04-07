//
//  RecipeCell.swift
//  Recipes
//
//  Created by Dan Seethaler on 4/2/16.
//  Copyright © 2016 Dan Seethaler. All rights reserved.
//

import UIKit
import Alamofire

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var recipe: Recipe!
    static var imageCache = NSCache()
    var request: Request?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(recipe: Recipe, img: UIImage?) {
        self.recipe = recipe
        
        titleLable.text = self.recipe.title.capitalizedString
        
        if img != nil {
            
            self.thumbImg.image = img
            print("Got image from cache")
            
        } else {
            
            request = Alamofire.request(.GET, recipe.imageURL).validate(contentType: ["image/*"]).response(completionHandler: { (request, response, data, err) in
                
                if err == nil {
                    
                    let img = UIImage(data: data!)!
                    self.thumbImg.image = img
                    RecipeCell.imageCache.setObject(img, forKey: self.recipe.imageURL)
                    
                    
                }else {
                    print(request)
                    print(err.debugDescription)
                }
                    
            })
        }
        
    }
    

}
