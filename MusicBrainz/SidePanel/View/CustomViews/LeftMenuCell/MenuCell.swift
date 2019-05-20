//
//  MenuCell.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import QuartzCore

class MenuCell: UITableViewCell {

    
    @IBOutlet weak var labelForMenuName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension CALayer {
    var borderColorFromUIColor: UIColor {
        get {
            return UIColor(cgColor : self.borderColor!)
        } set {
            self.borderColor = newValue.cgColor
        }
    }
}

extension MenuCell{
    

}
