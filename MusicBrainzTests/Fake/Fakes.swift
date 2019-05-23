//
//  Fakes.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 23/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
@testable import MusicBrainz

protocol FakeType {

    static func fake() -> Self

}

extension Coordinates: FakeType {

    static func fake() -> Coordinates {
        return Coordinates(latitude: "20.0", longitude: "30.0")
    }

}

extension PlaceLifeSpan: FakeType {

    static func fake() -> PlaceLifeSpan {
        return PlaceLifeSpan(ended: nil, begin: "1991", end: nil)
    }

}

extension Place: FakeType {

    static func fake() -> Place {
        return Place(id: "", type: nil, typeId: nil, score: 0, name: "Fake Place", coordinates: .fake(), lifeSpan: .fake(), address: "Fake Address")
    }

}

extension PlaceAnnotation: FakeType {

    static func fake() -> PlaceAnnotation {
        return PlaceAnnotation(from: .fake(), lifespanSince: shortFormatter.date(from: "1990")!)
    }

}

extension Location: FakeType {

    static func fake() -> Self {
        return .init(latitude: 20, longitude: 30)
    }

}

extension Region: FakeType {

    static func fake() -> Region {
        return Region(from: Location.fake(), span: 10)
    }

}

enum FakeError: Error {
    case unknown
}

extension PlacesList: FakeType {

    static func fake() -> PlacesList {
        return PlacesList(created: "2019-04-01", count: 52, offset: 50, places: [.fake(), .fake()])
    }

}
