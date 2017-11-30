//
//  FontInfoViewController.swift
//  MAPD714-F2017-Lesson9
//
//  Created by santhosh damodharan on 2017-11-29.
//  Copyright © 2017 santhosh damodharan. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {

    var font: UIFont!
    var favorite: Bool = false
    
    @IBOutlet weak var fontSampleLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            fontSampleLabel.font = font
            fontSampleLabel.text =
                "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVv"
                + "WwXxYyZz 0123456789"
            fontSizeSlider.value = Float(font.pointSize)
            fontSizeLabel.text = "\(Int(font.pointSize))"
            favoriteSwitch.isOn = favorite
        }
        @IBAction func slideFontSize(slider: UISlider) {
            let newSize = roundf(slider.value)
            fontSampleLabel.font = font.withSize(CGFloat(newSize))
            fontSizeLabel.text = "\(Int(newSize))"
        }
    
    @IBAction func toggleFavorite(sender: UISwitch) {
        let favoritesList = FavouritesList.sharedFavouritesList
        if sender.isOn {
            favoritesList.addFavourite(fontName: font.fontName)
        } else {
            favoritesList.removeFavourite(fontName: font.fontName)
        }
        
    }
    
    }

