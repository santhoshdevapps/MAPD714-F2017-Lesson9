//
//  FontListViewController.swift
//  MAPD714-F2017-Lesson9
//
//  Created by santhosh damodharan on 2017-11-29.
//  Copyright © 2017 santhosh damodharan. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {

    var fontNames: [String] = []
    var showsFavourites:Bool = false
    private var cellPointSize: CGFloat!
    private static let cellIdentifier = "FontName"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavourites {
            fontNames = FavouritesList.sharedFavouritesList.favourites
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferredTableViewFont =
            UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        
        if showsFavourites {
            navigationItem.rightBarButtonItem = editButtonItem
        }
        
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    

     // data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return fontNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FontListViewController.cellIdentifier,
                for: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            cell.textLabel?.text = fontNames[indexPath.row]
            cell.detailTextLabel?.text = fontNames[indexPath.row]
            return cell }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
       
        if segue.identifier == "ShowFontSizes" {
            let sizesVC =  segue.destination as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.title = font.fontName
            infoVC.font = font
            infoVC.favorite =
                FavouritesList.sharedFavouritesList.favourites.contains(font.fontName)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to
        destinationIndexPath: IndexPath) {
        FavouritesList.sharedFavouritesList.moveItem(fromIndex: sourceIndexPath.row,
                                                   toIndex: destinationIndexPath.row)
        fontNames = FavouritesList.sharedFavouritesList.favourites
    }

}
