//
//  PlacesLocationDataManagerTests.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import XCTest
@testable import MusicBrainz

private let latitude = 37.334922

private let longitude = -122.009033

private let span = 40.0

private let timeout = 1.0

final class PlacesDefaultLocationDataManagerTests: XCTestCase {

    private var dataManager: PlacesDefaultLocationDataManager!

    override func setUp() {
        super.setUp()

        dataManager = PlacesDefaultLocationDataManager(
            regionLatitude: latitude,
            regionLongitude: longitude,
            regionSpan: span
        )
    }

    func testInit() {
        XCTAssertNotNil(dataManager)
    }

    func testLocation_completesWithSuccess() {
        let expectation = self.expectation(description: "get result")
        dataManager.location { result in
            guard case .success(let location) = result else {
                XCTFail("Expected success")
                return
            }
            XCTAssertEqual(latitude, location.latitude)
            XCTAssertEqual(longitude, location.longitude)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testRegion_completesWithSuccess() {
        let expectation = self.expectation(description: "get result")
        dataManager.region { result in
            guard case .success(let region) = result else {
                XCTFail("Expected success")
                return
            }
            XCTAssertEqual(latitude, region.latitude)
            XCTAssertEqual(longitude, region.longitude)
            XCTAssertEqual(span, region.delta)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

}

final class PlacesLocationDataManagerTests: XCTestCase {

    private var dataManager: PlacesLocationDataManager!
    private var locationManagerSpy: LocationManagerSpy!

    override func setUp() {
        super.setUp()

        locationManagerSpy = LocationManagerSpy()
        dataManager = PlacesLocationDataManager(manager: locationManagerSpy, regionSpan: span)
    }

    func testInit() {
        XCTAssertNotNil(dataManager)
        XCTAssertTrue(locationManagerSpy.delegate === dataManager)
        XCTAssertFalse(locationManagerSpy.didRequestAlwaysAuthorization)
        XCTAssertFalse(locationManagerSpy.didRequestLocation)
    }

    func testLocation_RequestsManagerForLocation() {
        dataManager.location { _ in }
        XCTAssertTrue(locationManagerSpy.didRequestAlwaysAuthorization)
        XCTAssertTrue(locationManagerSpy.didRequestLocation)
    }

    func testRegion_RequestsManagerForLocation() {
        dataManager.region { _ in }
        XCTAssertTrue(locationManagerSpy.didRequestAlwaysAuthorization)
        XCTAssertTrue(locationManagerSpy.didRequestLocation)
    }

    func testLocation_completesWithSuccess() {
        locationManagerSpy.updatedLocation = LocationStub(latitude: latitude, longitude: longitude)

        let expectation = self.expectation(description: "get result")
        dataManager.location { result in
            guard case .success(let location) = result else {
                XCTFail("Expected success")
                return
            }
            XCTAssertEqual(latitude, location.latitude)
            XCTAssertEqual(longitude, location.longitude)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testRegion_completesWithSuccess() {
        locationManagerSpy.updatedLocation = LocationStub(latitude: latitude, longitude: longitude)

        let expectation = self.expectation(description: "get result")
        dataManager.region { result in
            guard case .success(let region) = result else {
                XCTFail("Expected success")
                return
            }
            XCTAssertEqual(latitude, region.latitude)
            XCTAssertEqual(longitude, region.longitude)
            XCTAssertEqual(span, region.delta)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testLocation_completesWithFailure() {
        enum ManagerError: Error {
            case unknown
        }
        locationManagerSpy.failureError = ManagerError.unknown

        let expectation = self.expectation(description: "get result")
        dataManager.location { result in
            guard case .failure(ManagerError.unknown) = result else {
                XCTFail("Expected unknown manager error")
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testRegion_completesWithFailure() {
        enum ManagerError: Error {
            case unknown
        }
        locationManagerSpy.failureError = ManagerError.unknown

        let expectation = self.expectation(description: "get result")
        dataManager.region { result in
            guard case .failure(ManagerError.unknown) = result else {
                XCTFail("Expected unknown manager error")
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

}
