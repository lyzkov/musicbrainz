//
//  Client.swift
//  MusicBrainz
//
//  Created by BOGU$ on 22/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

protocol ClientProtocol {
    func data<Endpoint: EndpointType>(from endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void)
    func decodedData<Resource: ResourceType>(from endpoint: Resource, completion: @escaping (Result<Resource.DataType, Error>) -> Void)
}

final class Client: ClientProtocol {

    let session = URLSession.shared

    func data<Endpoint: EndpointType>(from endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        _data(from: endpoint) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    func decodedData<Resource: ResourceType>(from endpoint: Resource, completion: @escaping (Result<Resource.DataType, Error>) -> Void) {
        _data(from: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(Resource.DataType.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    private func _data<Endpoint: EndpointType>(from endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        let base = Endpoint.api.base

        guard let request = try? endpoint.encoding.encode(endpoint, with: base.parameters + endpoint.parameters) else {
            return
        }

        print(request.url!.absoluteString)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                    completion(.success(data))
            }
        }
        .resume()
    }

}
