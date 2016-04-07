//
//  extensions.swift
//  Recipes
//
//  Created by Dan Seethaler on 4/3/16.
//  Copyright © 2016 Dan Seethaler. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(link link:String, contentMode mode: UIViewContentMode) {
        
        guard
            let url = NSURL(string: link)
            else {return}
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
            }
        }).resume()
    }
}