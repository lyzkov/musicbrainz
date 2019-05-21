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
    private var presenter: PlacesPresenterSpy!
    private var interactor: PlacesInteractor!

    override func setUp() {
        super.setUp()

        locationDataManagerSpy = PlacesLocationDataManagerSpy()
        presenter = PlacesPresenterSpy()
        interactor = PlacesInteractor(locationDataManager: locationDataManagerSpy)
        interactor.presenter = presenter
    }

    func testLoadRegion_invokesLocationDataManagerWithSuccess() {
        let latitude = 0.0, longitude = 0.0, span = 10.0
        locationDataManagerSpy.successRegion = Region(
            from: LocationStub(latitude: latitude, longitude: longitude),
            span: span
        )

        interactor.loadRegion()

        XCTAssertEqual(latitude, presenter.didPresentRegion?.latitude)
        XCTAssertEqual(longitude, presenter.didPresentRegion?.longitude)
        XCTAssertEqual(span, presenter.didPresentRegion?.delta)
        XCTAssertNil(locationDataManagerSpy.failureError)
    }

    func testLoadRegion_invokesLocationDataManagerWithFailure() {
        enum CustomError: Error {
            case unknown
        }
        locationDataManagerSpy.failureError = CustomError.unknown

        interactor.loadRegion()

        guard case .some(CustomError.unknown) = locationDataManagerSpy.failureError else {
            XCTFail("Expected unknown error")
            return
        }
        XCTAssertNil(locationDataManagerSpy.successRegion)
    }

}
