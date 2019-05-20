//
//  UIView.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
import UIKit

private enum Axis: StringLiteralType {
	case x = "x"
	case y = "y"
}

extension UIView {
	private func shake(on axis: Axis) {
		let animation = CAKeyframeAnimation(keyPath: "transform.translation.\(axis.rawValue)")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		animation.duration = 0.6
		animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
		layer.add(animation, forKey: "shake")
	}
	func shakeOnXAxis() {
		self.shake(on: .x)
	}
	func shakeOnYAxis() {
		self.shake(on: .y)
	}
}
