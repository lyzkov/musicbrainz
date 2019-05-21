//
//  Location.swift
//  MusicBrainz
//
//  Created by BOGU$ on 21/05/2019.
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
