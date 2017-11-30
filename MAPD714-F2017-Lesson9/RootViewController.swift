//
//  RootViewController.swift
//  MAPD714-F2017-Lesson9
//
//  Created by santhosh damodharan on 2017-11-29.
//  Copyright © 2017 santhosh damodharan. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    // private instance variables
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favouritesList: FavouritesList!
    private static let familyCell = "FamilyName"
    private static let favouritesCell = "Favourites"
    
    // This application event triggers everytime the view is going to be rendered
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // This application event triggers the first time the application is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = (UIFont.familyNames as [String]).sorted()
        let preferredTableViewFont =
            UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        favouritesList = FavouritesList.sharedFavouritesList
        tableView.estimatedRowHeight = cellPointSize
        
        }
    
    // utility methods
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            return fontName != nil ?
                UIFont(name: fontName!, size: cellPointSize) : nil
        } else {
            return nil }
    }
    
    // data source methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return favouritesList.favourites.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->
        String? {
            return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            if indexPath.section == 0 {
                // The font names list
                let cell = tableView.dequeueReusableCell(withIdentifier: RootViewController.familyCell, for: indexPath)
                cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
                cell.textLabel?.text = familyNames[indexPath.row]
                cell.detailTextLabel?.text = familyNames[indexPath.row]
                return cell
            } else {
                // The favorites list
                return tableView.dequeueReusableCell(withIdentifier: RootViewController.favouritesCell, for: indexPath)
            } }

}
