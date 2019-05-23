//
//  RestAPI.swift
//  MusicBrainz
//
//  Created by BOGU$ on 22/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

protocol RestAPI {
    static var base: APIConfiguration { get }
}

struct APIConfiguration {

    let url: URL
    let parameters: Parameters
    let headers: HTTPHeaders

    init(url: URL, parameters: Parameters = [:], headers: HTTPHeaders = [:]) {
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }

}
