//
//  MusicBrainzAPI.swift
//  MusicBrainz
//
//  Created by BOGU$ on 22/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

struct MusicBrainzAPI: RestAPI {

    static var base = APIConfiguration(url: URL(string: "http://musicbrainz.org/ws/2/")!)

    struct PlacesEndpoint: ResourceType {
        typealias DataType = PlacesList

        static var api: RestAPI.Type = MusicBrainzAPI.self

        let method: HTTPMethod = .get

        let path: String = "place/"

        let parameters: Parameters

        let encoding: ParameterEncoding = URLPlacesSearchEncoding()

        init(latitude: Double, longitude: Double, span: Double, begin: Double, offset: Int, limit: Int) {
            let delta = span/2
            parameters = [
                "query":
                    ("lat" >> (latitude +- delta)) &
                    ("long" >> (longitude +- delta)) &
                    ("begin" >> (>begin)),
                "offset": offset,
                "limit": limit,
                "fmt": "json"
            ]
        }

    }

}
