//
//  SingleDogTableViewCell.swift
//  TestDogsApp
//
//  Created by denebtech on 05/07/2018.
//  Copyright © 2018 denebtech. All rights reserved.
//

import UIKit

class SingleDogTableViewCell : UITableViewCell {
    @IBOutlet weak var dogImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.isHidden = true
    }
}
