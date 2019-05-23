//
//  PlacesViewSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import XCTest
@testable import MusicBrainz

final class PlacesViewSpy: PlacesViewProtocol {

    var presenter: PlacesPresenterInputProtocol?

    var didPresentRegion: RegionType?

    func present(region: RegionType) {
        didPresentRegion = region
    }

    var didAddPlaces: [PlaceAnnotation] = []

    func add(place: PlaceAnnotation) {
        didAddPlaces.append(place)
    }

    var didRemovePlaces: [PlaceAnnotation] = []

    var didRemoveExpectation: XCTestExpectation? = nil {
        willSet {
            newValue?.assertForOverFulfill = false
        }
    }

    func remove(place: PlaceAnnotation) {
        didRemoveExpectation?.fulfill()
        didRemovePlaces.append(place)
    }

}
