//
//  FavouritesList.swift
//  MAPD714-F2017-Lesson9
//
//  Created by santhosh damodharan on 2017-11-29.
//  Copyright © 2017 santhosh damodharan. All rights reserved.
//

import Foundation
import UIKit

class FavouritesList {
    
    //private instance variable
    static let sharedFavouritesList = FavouritesList()
    private(set) var favourites:[String]
    
    //constructor
    init(){
        
        let defaults = UserDefaults.standard
        let storedFavourites = defaults.object(forKey: "favourites") as? [String]
        favourites = storedFavourites != nil ? storedFavourites! : []
    }
    
    // This method  adds a font to the user preferences file
    
    func addFavourite(fontName: String) {
     
        if !favourites.contains(fontName){
        favourites.append(fontName)
        saveFavourites()
        }
    }
    
    // This method saves font favourites to the user preferences file
   private func saveFavourites() {
        let defaults = UserDefaults.standard
    defaults.set(favourites, forKey: "favourites")
    defaults.synchronize()
    }
    
    // This method removes a favourite from the user preferences file
    func removeFavourite(fontName : String) {
        if let index = favourites.index(of: fontName){
        favourites.remove(at: index)
        saveFavourites()
        }
        
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item = favourites[from]
        favourites.remove(at: from)
        favourites.insert(item, at: to)
        saveFavourites()
    }
    
}
