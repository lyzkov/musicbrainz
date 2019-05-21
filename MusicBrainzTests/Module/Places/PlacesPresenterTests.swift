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

    func testPresent_invokesViewWithRegion() {
        let latitude = 0.0, longitude = 0.0, span = 10.0
        let region = Region(
            from: LocationStub(latitude: latitude, longitude: longitude),
            span: span
        )

        presenter.present(region: region)

        XCTAssertEqual(latitude, view.didPresentRegion?.latitude)
        XCTAssertEqual(longitude, view.didPresentRegion?.longitude)
        XCTAssertEqual(span, view.didPresentRegion?.delta)
        XCTAssertNil(wireframe.didPresentAlertError)
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
