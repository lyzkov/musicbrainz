//
//  PlacesLocationDataManagerSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

@testable import MusicBrainz

final class PlacesLocationDataManagerSpy: PlacesLocationDataManagerInputProtocol {

    var successLocation: LocationType?

    var successRegion: RegionType?

    var failureError: Error?

    func location(completion: @escaping (Result<LocationType, Error>) -> Void) {
        if let error = failureError {
            completion(.failure(error))
            return
        } else if let location = successLocation {
            completion(.success(location))
            return
        }
    }

    func region(completion: @escaping (Result<RegionType, Error>) -> Void) {
        if let error = failureError {
            completion(.failure(error))
            return
        } else if let region = successRegion {
            completion(.success(region))
            return
        }
    }

}
