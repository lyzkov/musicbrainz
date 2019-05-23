//
//  PlacesAPIDataManager.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import Foundation

final class PlacesAPIDataManager: PlacesAPIDataManagerInputProtocol {

    private let client: ClientProtocol

    init(client: ClientProtocol = Client()) {
        self.client = client
    }

    static var limit = 100

    func fetch(region: RegionType, since: Date, offset: Int, limit: Int = limit, completion: @escaping (Result<[Place], Error>) -> Void) {
        let endpoint = MusicBrainzAPI.PlacesEndpoint(region: region, since: since, offset: offset, limit: limit)

        return client.decodedData(from: endpoint) { result in
            switch result {
            case .success(let placesList):
                completion(.success(placesList.places))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchAll(region: RegionType, since: Date, completion: @escaping (Result<[Place], Error>) -> Void) {
        fetchAll(region: region, since: since, offset: 0, limit: PlacesAPIDataManager.limit, acc: [], completion: completion)
    }

    private func fetchAll(region: RegionType, since: Date, offset: Int = 0, limit: Int = 100, acc: [Place] = [], completion: @escaping (Result<[Place], Error>) -> Void) {
        let endpoint = MusicBrainzAPI.PlacesEndpoint(region: region, since: since, offset: offset, limit: limit)

        return client.decodedData(from: endpoint) { result in
            switch result {
            case .success(let placesList):
                let isNext = placesList.offset + limit < placesList.count
                if isNext {
                    self.fetchAll(
                        region: region,
                        since: since,
                        offset: offset + limit,
                        limit: limit,
                        acc: acc + placesList.places,
                        completion: completion
                    )
                } else {
                    completion(.success(acc + placesList.places))
                }
            case .failure(let error):
                completion(.success(acc))
                completion(.failure(error))
            }
        }
    }

}

extension MusicBrainzAPI.PlacesEndpoint {

    init(region: RegionType, since: Date, offset: Int, limit: Int) {
        let begin = Double(shortFormatter.string(from: since)) ?? 0
        self.init(
            latitude: region.latitude,
            longitude: region.longitude,
            span: region.delta,
            begin: begin,
            offset: offset,
            limit: limit
        )
    }

}
