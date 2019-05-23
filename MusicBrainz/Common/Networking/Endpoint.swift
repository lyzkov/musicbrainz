//
//  Endpoint.swift
//  MusicBrainz
//
//  Created by BOGU$ on 22/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation


public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol EndpointType: URLRequestConvertible {
    static var api: RestAPI.Type { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders { get }
}

protocol ResourceType: EndpointType {
    associatedtype DataType: Decodable
}

extension EndpointType {

    var headers: HTTPHeaders {
        return [:]
    }

    var parameters: Parameters {
        return [:]
    }

}

extension EndpointType {

    func asURLRequest() throws -> URLRequest {
        let base = Self.api.base

        var request = URLRequest(
            url: base.url + path,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = base.headers + headers

        return request
    }

}
