//
//  PlacesInteractorTests.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import XCTest
@testable import MusicBrainz

final class PlacesInteractorTests: XCTestCase {

    private var locationDataManagerSpy: PlacesLocationDataManagerSpy!
    private var apiDataManagerSpy: PlacesAPIDataManagerSpy!
    private var presenter: PlacesPresenterSpy!
    private var interactor: PlacesInteractor!

    override func setUp() {
        super.setUp()

        locationDataManagerSpy = PlacesLocationDataManagerSpy()
        apiDataManagerSpy = PlacesAPIDataManagerSpy()
        presenter = PlacesPresenterSpy()
        interactor = PlacesInteractor(apiDataManager: apiDataManagerSpy, locationDataManager: locationDataManagerSpy)
        interactor.presenter = presenter
    }

    func testLoadRegion_whenFetchingLocationIsSuccessful_thenPresentsRegion() {
        let region: Region = .fake()
        locationDataManagerSpy.successRegion = region

        interactor.loadRegion()

        XCTAssertEqual(region.latitude, presenter.didPresentRegion?.latitude)
        XCTAssertEqual(region.longitude, presenter.didPresentRegion?.longitude)
        XCTAssertEqual(region.delta, presenter.didPresentRegion?.delta)
        XCTAssertNil(locationDataManagerSpy.failureError)
    }

    func testLoadRegion_whenFetchingLocationFailed_thenPresentsError() {
        locationDataManagerSpy.failureError = FakeError.unknown

        interactor.loadRegion()

        guard case .some(FakeError.unknown) = presenter.didShowError else {
            XCTFail("Expected unknown error")
            return
        }
        XCTAssertNil(presenter.didPresentRegion)
    }

    func testLoadPlaces_whenFetchingPlacesIsSuccessful_thenPresentsPlaces() {
        let places: [Place] = [.fake(), .fake()]
        apiDataManagerSpy.resultFetchAll = .success(places)

        let since = shortFormatter.date(from: "1990")!
        interactor.loadPlaces(region: Region.fake(), since: since)

        let expectedAnnotations = places.map { PlaceAnnotation(from: $0, lifespanSince: since) }
        guard let resultingAnnotations = presenter.didPresentPlaces else {
            XCTFail()
            return
        }

        for (expected, result) in zip(expectedAnnotations, resultingAnnotations) {
            XCTAssertEqual(expected.longitude, result.longitude)
            XCTAssertEqual(expected.title, result.title)
            XCTAssertEqual(expected.subtitle, result.subtitle)
            XCTAssertEqual(expected.lifespan, result.lifespan)
        }
    }

    func testLoadPlaces_whenFetchingPlacesFailed_thenPresentsError() {
        apiDataManagerSpy.resultFetchAll = .failure(FakeError.unknown)

        let since = shortFormatter.date(from: "1990")!
        interactor.loadPlaces(region: Region.fake(), since: since)

        guard case .some(FakeError.unknown) = presenter.didShowError else {
            XCTFail("Expected unknown error")
            return
        }
        XCTAssertNil(presenter.didPresentPlaces)
    }

}
