//
//  Double.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

extension Double {
    func round(to: Int) -> Double {
        let divisor = pow(10.0, Double(to))
        return Darwin.round(self * divisor) / divisor
    }
}
