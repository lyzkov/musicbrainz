//
//  Region.swift
//  MusicBrainz
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

protocol RegionType: LocationType {
    var delta: Double { get }
}

struct Region: RegionType {

    let latitude: Double
    let longitude: Double
    let delta: Double

    init(from location: LocationType, span: Double) {
        latitude = location.latitude
        longitude = location.longitude
        delta = span
    }

}
