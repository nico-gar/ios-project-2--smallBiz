//
//  DefaultItemsCollectionViewCell.swift
//  smallBiz
//
//  Created by Nicolas Garaycochea on 1/18/23.
//

import UIKit

class DefaultItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var defaultItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }
    
}
