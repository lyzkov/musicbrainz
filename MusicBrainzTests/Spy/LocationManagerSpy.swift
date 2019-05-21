//
//  LocationManagerSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

@testable import MusicBrainz

final class LocationManagerSpy: LocationManagerProtocol {

    var didRequestAlwaysAuthorization = false

    var didRequestLocation = false

    var updatedLocation: LocationType?

    var failureError: Error?

    func requestAlwaysAuthorization() {
        didRequestAlwaysAuthorization = true
    }

    func requestLocation() {
        didRequestLocation = true

        if let error = failureError {
            delegate?.location(didFail: error)
        }

        if let location = updatedLocation {
            delegate?.location(didUpdate: location)
        }
    }

    var delegate: LocationManagerDelegate?

}

struct LocationStub: LocationType {

    var latitude: Double
    var longitude: Double

}
