//
//  ParameterEncoding.swift
//  MusicBrainz
//
//  Created by BOGU$ on 22/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

final class URLPlacesSearchEncoding: ParameterEncoding {

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()

        guard let parameters = parameters,
            var url = request.url?.absoluteString else {
                return request
        }

        let pathComponents = parameters
            .reduce("") { pathComponents, parameter in
                let (name, value) = parameter
                return pathComponents + "&\(name)=\(value)"
            }
            .dropFirst()
        url = "\(url)?\(pathComponents)"
        request.url = URL(string: url)

        return request
    }

}

indirect enum QueryExpression: CustomStringConvertible {
    case range(from: Double, to: Double)
    case delta(center: Double, delta: Double)
    case greater(than: Double)
    case param(key: String, expression: QueryExpression)
    case and(first: QueryExpression, second: QueryExpression)

    var description: String {
        switch self {
        case let .param(key, expression):
            return "\(key):\(expression)"
        case let .range(from, to):
            return "[\(from)%20TO%20\(to)]"
        case let .delta(center, delta):
            return "[\(center-delta)%20TO%20\(center+delta)]"
        case let .greater(than):
            return "[\(Int(than))%20TO%20*]"
        case let .and(first, second):
            return "\(first)%20AND%20\(second)"
        }
    }
}

func & (first: QueryExpression, second: QueryExpression) -> QueryExpression {
    return .and(first: first, second: second)
}

infix operator ~

func ~ (from: Double, to: Double) -> QueryExpression {
    return .range(from: from, to: to)
}

infix operator +-

func +- (center: Double, delta: Double) -> QueryExpression {
    return .delta(center: center, delta: delta)
}

infix operator >>

func >> (key: String, expression: QueryExpression) -> QueryExpression {
    return .param(key: key, expression: expression)
}

prefix operator >

prefix func > (than: Double) -> QueryExpression {
    return .greater(than: than)
}
