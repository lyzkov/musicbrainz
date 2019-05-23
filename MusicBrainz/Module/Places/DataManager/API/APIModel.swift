//
//  APIModel.swift
//  MusicBrainz
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

struct PlacesList: Codable {
    let created: String?
    let count, offset: Int
    let places: [Place]
}

struct Place: Codable {
    let id: String
    let type, typeId: String?
    let score: Int
    let name: String
    let coordinates: Coordinates
    let lifeSpan: PlaceLifeSpan
    let address: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case typeId = "type-id"
        case score, name, coordinates
        case lifeSpan = "life-span"
        case address
    }
}

struct Coordinates: Codable {
    let latitude, longitude: String
}

struct PlaceLifeSpan: Codable {
    let ended: Bool?
    let begin, end: String?
}

extension PlaceLifeSpan {

    var beginDate: Date? {
        guard let begin = begin else {
            return nil
        }

        return longFormatter.date(from: begin) ?? shortFormatter.date(from: begin)
    }

    func lifeSpan(since date: Date) -> Int? {
        guard let beginDate = beginDate,
            let since = Int(shortFormatter.string(from: beginDate)),
            let to = Int(shortFormatter.string(from: date)) else {
                return nil
        }

        return since - to
    }

}

var longFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

var shortFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
}()
