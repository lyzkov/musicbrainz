//
//  ClientSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 23/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
@testable import MusicBrainz

final class ClientSpy: ClientProtocol {

    var dataResult: Result<Data, Error>?

    var didDataEndpoint: EndpointType?

    func data<Endpoint>(from endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) where Endpoint: EndpointType {
        didDataEndpoint = endpoint
        if let result = dataResult {
            completion(result)
        }
    }

    var decodedDataResult: Result<Decodable, Error>?

    var didDecodedDataEndpoint: EndpointType?

    func decodedData<Resource>(from endpoint: Resource, completion: @escaping (Result<Resource.DataType, Error>) -> Void) where Resource: ResourceType {
        didDecodedDataEndpoint = endpoint
        switch decodedDataResult {
        case .some(.success(let decodedData)):
            completion(.success(decodedData as! Resource.DataType))
        case .some(.failure(let error)):
            completion(.failure(error))
        default:
            return
        }
    }

}
