//
//  PlacesPresenterSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

@testable import MusicBrainz

final class PlacesPresenterSpy: PlacesPresenterOutputProtocol {

    var didPresentRegion: RegionType?

    func present(region: RegionType) {
        didPresentRegion = region
    }

    var didShowError: Error?

    func show(error: Error) {
        didShowError = error
    }

    var didPresentPlaces: [PlaceAnnotation]?

    func present(places: [PlaceAnnotation]) {
        didPresentPlaces = places
    }

}
