//
//  PlacesLocationDataManager.swift
//  MusicBrainz
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import CoreLocation

private let appleParkWayCoordinates = CLLocationCoordinate2DMake(37.334922, -122.009033)

private let usRegionSpan = 40.0

final class PlacesDefaultLocationDataManager: PlacesLocationDataManagerInputProtocol {

    private let regionLatitude: Double

    private let regionLongitude: Double

    private let regionSpan: Double

    init(regionLatitude: Double = appleParkWayCoordinates.latitude, regionLongitude: Double = appleParkWayCoordinates.longitude, regionSpan: Double = usRegionSpan) {
        self.regionLatitude = regionLatitude
        self.regionLongitude = regionLongitude
        self.regionSpan = regionSpan
    }

    func location(completion: @escaping (Result<LocationType, Error>) -> Void) {
        completion(.success(defaultLocation))
    }

    func region(completion: @escaping (Result<RegionType, Error>) -> Void) {
        completion(.success(defaultRegion))
    }

    private var defaultLocation: LocationType {
        return CLLocation(latitude: regionLatitude, longitude: regionLongitude)
    }

    private var defaultRegion: RegionType {
        return Region(from: defaultLocation, span: regionSpan)
    }

}

final class PlacesLocationDataManager: NSObject, PlacesLocationDataManagerInputProtocol {

    private var manager: LocationManagerProtocol!

    private var locationAvailable: ((Result<LocationType, Error>) -> Void)?

    private var regionSpan: Double!

    private override init() {

    }

    convenience init(manager: LocationManagerProtocol = CLLocationManager(), regionSpan: Double = usRegionSpan) {
        self.init()
        self.manager = manager
        self.regionSpan = regionSpan

        self.manager.delegate = self
    }

    func location(completion: @escaping (Result<LocationType, Error>) -> Void) {
        locationAvailable = completion
        manager.requestAlwaysAuthorization()
        manager.requestLocation()
    }

    func region(completion: @escaping (Result<RegionType, Error>) -> Void) {
        let span = regionSpan!
        location { result in
            switch result {
            case .success(let location):
                completion(.success(Region(from: location, span: span)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

extension PlacesLocationDataManager: LocationManagerDelegate {

    func location(didUpdate location: LocationType) {
        locationAvailable?(.success(location))
        locationAvailable = nil
    }

    func location(didFail error: Error) {
        locationAvailable?(.failure(error))
        locationAvailable = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
            return
        }
        self.location(didUpdate: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.location(didFail: error)
    }

}

protocol LocationManagerProtocol {
    func requestLocation()
    func requestAlwaysAuthorization()
    var delegate: LocationManagerDelegate? { get set }
}

protocol LocationManagerDelegate: CLLocationManagerDelegate {
    func location(didUpdate location: LocationType)
    func location(didFail error: Error)
}

extension CLLocationManager: LocationManagerProtocol {

    var delegate: LocationManagerDelegate? {
        get {
            return self.value(forKey: "delegate") as? LocationManagerDelegate
        }
        set {
            self.setValue(newValue, forKey: "delegate")
        }
    }

}
