//: A MapKit based Playground

import MapKit
import PlaygroundSupport

import Foundation

struct PlacesList: Codable {
    let created: String
    let count, offset: Int
    let places: [Place]
}

struct Place: Codable {
    let id: String
    let type, typeId: String?
    let score: Int
    let name: String
    let coordinates: Coordinates
    //    let area: Area
    let lifeSpan: PlaceLifeSpan
    let address: String?
    //    let aliases: [Alias]?

    enum CodingKeys: String, CodingKey {
        case id, type
        case typeId = "type-id"
        case score, name, coordinates
        //        case area
        case lifeSpan = "life-span"
        case address
        //        case aliases
    }
}

struct Alias: Codable {
    let sortName: String
    let typeId: String?
    let name: String
    let locale: String?
    let type: AliasType?
    let primary: String?
    let beginDate, endDate: String?

    enum CodingKeys: String, CodingKey {
        case sortName = "sort-name"
        case typeId = "type-id"
        case name, locale, type, primary
        case beginDate = "begin-date"
        case endDate = "end-date"
    }
}

enum AliasType: String, Codable {
    case placeName = "Place name"
    case searchHint = "Search hint"
}

struct Area: Codable {
    let id: String
    let type: AreaType
    let typeId, name, sortName: String
    let lifeSpan: AreaLifeSpan

    enum CodingKeys: String, CodingKey {
        case id, type
        case typeId = "type-id"
        case name
        case sortName = "sort-name"
        case lifeSpan = "life-span"
    }
}

struct AreaLifeSpan: Codable {
    let ended: String?
}

enum AreaType: String, Codable {
    case city = "City"
    case district = "District"
    case municipality = "Municipality"
    case subdivision = "Subdivision"
}

struct Coordinates: Codable {
    let latitude, longitude: String

    var lat: Double {
        return Double(latitude)!
    }

    var lon: Double {
        return Double(longitude)!
    }
}

struct PlaceLifeSpan: Codable {
    let ended: Bool?
    let begin, end: String?
}

extension PlaceLifeSpan {

    static var longFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static var shortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()

    var beginDate: Date? {
        guard let begin = begin else {
            return nil
        }

        return PlaceLifeSpan.longFormatter.date(from: begin) ?? PlaceLifeSpan.shortFormatter.date(from: begin)
    }

    func lifeSpan(since date: Date) -> Int? {
        guard let beginDate = beginDate,
            let since = Int(PlaceLifeSpan.shortFormatter.string(from: beginDate)),
            let to = Int(PlaceLifeSpan.shortFormatter.string(from: date)) else {
                return nil
        }

        return since - to
    }

}

// Define Region

let appleParkWayCoordinates = CLLocationCoordinate2DMake(37.334922, -122.009033)

var mapRegion = MKCoordinateRegion()

let mapRegionSpan = 40.0
mapRegion.center = appleParkWayCoordinates
mapRegion.span.latitudeDelta = mapRegionSpan
mapRegion.span.longitudeDelta = mapRegionSpan


// MAP VIEW

// Now let's create a MKMapView
let mapView = MKMapView(frame: CGRect(x:0, y:0, width:800, height:800))

mapView.setRegion(mapRegion, animated: true)

// Add the created mapView to our Playground Live View
PlaygroundPage.current.liveView = mapView

// API Request

let headers = [
    "cache-control": "no-cache",
    "Postman-Token": "960a0fae-ecb3-4c86-95b9-4c7742eb48a1"
]

let latFrom = mapRegion.center.latitude - mapRegionSpan/2
let latTo = mapRegion.center.latitude + mapRegionSpan/2
let lonFrom = mapRegion.center.longitude - mapRegionSpan/2
let lonTo = mapRegion.center.longitude + mapRegionSpan/2

let offset = 0

let beginDate = "1990"

let urlString = "http://musicbrainz.org/ws/2/place/?query=lat:[\(latFrom)%20TO%20\(latTo)]%20AND%20long:[\(lonFrom)%20TO%20\(lonTo)]&fmt=json&offset=\(offset)"

print(urlString)

let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                  cachePolicy: .useProtocolCachePolicy,
                                  timeoutInterval: 10.0)
request.httpMethod = "GET"
request.allHTTPHeaderFields = headers

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
    if (error != nil) {
        print(error)
    } else {
        let httpResponse = response as? HTTPURLResponse
        //        print(httpResponse)
        guard let data = data else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let since = formatter.date(from: beginDate)!

        //        print(String(data: data, encoding: .utf8))

        var placesList: PlacesList? = nil
        do {
            placesList = try JSONDecoder().decode(PlacesList.self, from: data)
        } catch let decodeError {
            print(decodeError)
        }
        let places = placesList?.places.filter { $0.lifeSpan.beginDate ?? Date() > since }

        print(places?.map { $0.name })

        DispatchQueue.main.async { [places] in
            places?.map { ($0.name, $0.address, $0.coordinates, $0.lifeSpan.lifeSpan(since: since)) }
                .forEach { name, address, coordinates, lifeSpan in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(coordinates.lat, coordinates.lon)
                    annotation.title = name
                    annotation.subtitle = address ?? ""

                    mapView.addAnnotation(annotation)

                    print(lifeSpan)

                    Timer.scheduledTimer(withTimeInterval: TimeInterval(lifeSpan ?? 0), repeats: false) { _ in
                        mapView.removeAnnotation(annotation)
                    }
            }
        }
    }
})

dataTask.resume()

