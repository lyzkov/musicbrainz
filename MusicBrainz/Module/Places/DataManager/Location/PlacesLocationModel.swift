//
//  PlacesLocationModel.swift
//  MusicBrainz
//
//  Created by BOGU$ on 24/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import CoreLocation

protocol LocationType {
    var latitude: Double { get }
    var longitude: Double { get }
}

typealias Location = CLLocation

extension Location: LocationType {

    var latitude: Double {
        return coordinate.latitude
    }

    var longitude: Double {
        return coordinate.longitude
    }

}

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
