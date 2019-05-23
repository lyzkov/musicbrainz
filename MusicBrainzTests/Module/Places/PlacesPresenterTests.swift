//
//  PlacesPresenterTests.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import XCTest
@testable import MusicBrainz

final class PlacesPresenterTests: XCTestCase {

    private var view: PlacesViewSpy!
    private var interactor: PlacesInteractorSpy!
    private var wireframe: PlacesWireframeSpy!
    private var presenter: PlacesPresenter!

    override func setUp() {
        super.setUp()

        view = PlacesViewSpy()
        interactor = PlacesInteractorSpy()
        wireframe = PlacesWireframeSpy()
        presenter = PlacesPresenter(interface: view, interactor: interactor, wireframe: wireframe)
    }

    func testInit_setsUpInteractor() {
        XCTAssertNotNil(interactor.presenter)
    }

    func testLoad_invokesInteractor() {
        presenter.load()

        XCTAssertTrue(interactor.didLoadRegion)
    }

    func testPresentRegion_presentsRegionInView() {
        let region = Region.fake()

        presenter.present(region: region)

        XCTAssertEqual(region, view.didPresentRegion as? Region)
        XCTAssertNil(wireframe.didPresentAlertError)
    }

    func testPresentPlaces_addsPlacesInView() {
        let places: [PlaceAnnotation] = [.fake(), .fake()]

        presenter.present(places: places)

        XCTAssertEqual(places, view.didAddPlaces)
    }

    func testPresentPlaces_removesPlacesFromViewAfterALifeSpan() {
        let places: [PlaceAnnotation] = [.fake(), .fake()]

        presenter.present(places: places)

        XCTAssertTrue(view.didRemovePlaces.isEmpty)

        view.didRemoveExpectation = expectation(description: "remove place")
        waitForExpectations(timeout: TimeInterval(places.first!.lifespan!)) { _ in
            XCTAssertEqual(places, self.view.didRemovePlaces)
        }
    }

    func testShow_invokesWireframeAlertWithError() {
        enum CustomError: Error {
            case unknown
        }
        presenter.show(error: CustomError.unknown)

        guard case .some(CustomError.unknown) = wireframe.didPresentAlertError else {
            XCTFail("Expected unknown error")
            return
        }
        XCTAssertNil(view.didPresentRegion)
    }

}
