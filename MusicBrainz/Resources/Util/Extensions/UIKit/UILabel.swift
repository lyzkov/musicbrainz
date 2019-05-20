//
//  UILabel.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

extension UILabel {
	
	func startBlink() {
		UIView.animate(withDuration: 0.8,
		               delay:0.0,
		               options:[.autoreverse, .repeat],
		               animations: {
						self.alpha = 0
		}, completion: nil)
	}
	
	func stopBlink() {
		alpha = 1
		layer.removeAllAnimations()
	}
}
