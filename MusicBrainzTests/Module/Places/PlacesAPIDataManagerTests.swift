//
//  PlacesAPIDataManagerTests.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 23/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import XCTest
@testable import MusicBrainz

final class PlacesAPIDataManagerTests: XCTestCase {

    var clientSpy: ClientSpy!
    var manager: PlacesAPIDataManager!

    override func setUp() {
        super.setUp()

        clientSpy = .init()
        manager = .init(client: clientSpy)
        PlacesAPIDataManager.limit = 100
    }

    func testFetch_retrievesDecodedDataFromClient_thenSucceed() {
        let placesList: PlacesList = .fake()
        clientSpy.decodedDataResult = .success(placesList)

        let expectation = self.expectation(description: "async")

        let region: Region = .fake()
        let since = shortFormatter.date(from: "1990")!
        let offset = placesList.offset
        let limit = placesList.count - offset
        let expectedEndpoint = MusicBrainzAPI.PlacesEndpoint(region: region, since: since, offset: offset, limit: limit)
        manager.fetch(region: region, since: since, offset: offset, limit: limit) { [unowned self] result in
            let spiedEndpoint = self.clientSpy.didDecodedDataEndpoint as! MusicBrainzAPI.PlacesEndpoint
            XCTAssertEqual(expectedEndpoint, spiedEndpoint)
            if case .success(let places) = result {
                for (expected, result) in zip(placesList.places, places) {
                    XCTAssertEqual(expected, result)
                }
            } else {
                XCTFail("Expected success result")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetch_retrievesErrorFromClient_thenFails() {
        clientSpy.decodedDataResult = .failure(FakeError.unknown)

        let expectation = self.expectation(description: "async")

        let region: Region = .fake()
        let since = shortFormatter.date(from: "1990")!
        let offset = 0
        let limit = 50
        let expectedEndpoint = MusicBrainzAPI.PlacesEndpoint(region: region, since: since, offset: offset, limit: limit)
        manager.fetch(region: region, since: since, offset: offset, limit: limit) { [unowned self] result in
            let spiedEndpoint = self.clientSpy.didDecodedDataEndpoint as! MusicBrainzAPI.PlacesEndpoint
            XCTAssertEqual(expectedEndpoint, spiedEndpoint)
            switch result {
            case .failure(FakeError.unknown):
                expectation.fulfill()
            default:
                XCTFail("Expected empty places list and then unknown error")
            }
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetchAll_retrievesDecodedDataFromClient_thenSucceed() {
        let placesList: PlacesList = .fake()
        clientSpy.decodedDataResult = .success(placesList)

        let expectation = self.expectation(description: "async")

        let region: Region = .fake()
        let since = shortFormatter.date(from: "1990")!
        let offset = placesList.offset
        let limit = placesList.count - offset
        let expectedEndpoint = MusicBrainzAPI.PlacesEndpoint(region: region, since: since, offset: offset, limit: limit)
        PlacesAPIDataManager.limit = limit
        manager.fetchAll(region: region, since: since) { [unowned self] result in
            let spiedEndpoint = self.clientSpy.didDecodedDataEndpoint as! MusicBrainzAPI.PlacesEndpoint
            XCTAssertEqual(expectedEndpoint, spiedEndpoint)
            if case .success(let places) = result {
                for (expected, result) in zip(placesList.places, places) {
                    XCTAssertEqual(expected, result)
                }
            } else {
                XCTFail("Expected success result")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetchAll_retrievesErrorFromClient_thenFails() {
        clientSpy.decodedDataResult = .failure(FakeError.unknown)

        let expectation = self.expectation(description: "async")

        let region: Region = .fake()
        let since = shortFormatter.date(from: "1990")!
        let offset = 0
        let limit = 50
        let expectedEndpoint = MusicBrainzAPI.PlacesEndpoint(region: region, since: since, offset: offset, limit: limit)
        PlacesAPIDataManager.limit = limit
        manager.fetchAll(region: region, since: since) { [unowned self] result in
            let spiedEndpoint = self.clientSpy.didDecodedDataEndpoint as! MusicBrainzAPI.PlacesEndpoint
            XCTAssertEqual(expectedEndpoint, spiedEndpoint)
            switch result {
            case .success(let places):
                XCTAssertTrue(places.isEmpty)
            case .failure(FakeError.unknown):
                expectation.fulfill()
            default:
                XCTFail("Expected empty places list and then unknown error")
            }
        }

        waitForExpectations(timeout: 1.0)
    }

}
