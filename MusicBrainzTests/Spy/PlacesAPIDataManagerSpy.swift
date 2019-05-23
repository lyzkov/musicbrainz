//
//  PlacesAPIDataManagerSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 23/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
@testable import MusicBrainz

final class PlacesAPIDataManagerSpy: PlacesAPIDataManagerInputProtocol {

    var resultFetch: Result<[Place], Error>? = nil

    func fetch(region: RegionType, since: Date, offset: Int, limit: Int, completion: @escaping (Result<[Place], Error>) -> Void) {
        if let result = resultFetch {
            completion(result)
        }
    }

    var resultFetchAll: Result<[Place], Error>? = nil

    func fetchAll(region: RegionType, since: Date, completion: @escaping (Result<[Place], Error>) -> Void) {
        if let result = resultFetchAll {
            completion(result)
        }
    }

}
