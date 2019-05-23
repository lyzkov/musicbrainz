//
//  Model+Equatable.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 23/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
@testable import MusicBrainz

extension Place: Equatable {

    public static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name &&
            lhs.address == rhs.address &&
            lhs.coordinates.latitude == rhs.coordinates.latitude &&
            rhs.coordinates.longitude == rhs.coordinates.longitude
    }

}

extension Region: Equatable {

    public static func == (lhs: Region, rhs: Region) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.delta == rhs.delta
    }

}

extension MusicBrainzAPI.PlacesEndpoint: Equatable {

    public static func == (lhs: MusicBrainzAPI.PlacesEndpoint, rhs: MusicBrainzAPI.PlacesEndpoint) -> Bool {
        return (try? lhs.asURLRequest()) == (try? rhs.asURLRequest())
    }

}
