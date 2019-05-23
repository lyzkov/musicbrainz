//
//  PlacesInteractor.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import Foundation

protocol PlaceAnnotationType: class, LocationType {
    var title: String? { get }
    var subtitle: String? { get }
    var lifespan: Int? { get }
}

final class PlaceAnnotation: NSObject, PlaceAnnotationType {
    let latitude: Double
    let longitude: Double
    let title: String?
    let subtitle: String?
    let lifespan: Int?

    init(from place: Place, lifespanSince: Date) {
        latitude = Double(place.coordinates.latitude) ?? 0
        longitude = Double(place.coordinates.longitude) ?? 0
        title = place.name
        subtitle = place.address
        lifespan = place.lifeSpan.lifeSpan(since: lifespanSince)
    }
}

final class PlacesInteractor: PlacesInteractorProtocol {

    weak var presenter: PlacesPresenterOutputProtocol?
    let apiDataManager: PlacesAPIDataManagerInputProtocol
    let locationDataManager: PlacesLocationDataManagerInputProtocol
    
    init(apiDataManager: PlacesAPIDataManagerInputProtocol = PlacesAPIDataManager(),
         locationDataManager: PlacesLocationDataManagerInputProtocol = PlacesLocationDataManager()) {
        self.apiDataManager = apiDataManager
        self.locationDataManager = locationDataManager
    }
    
    func loadRegion() {
        locationDataManager.region { [unowned self] result in
            switch result {
            case .success(let region):
                self.presenter?.present(region: region)
            case .failure(let error):
                self.presenter?.show(error: error)
            }
        }
    }

    func loadPlaces(region: RegionType, since: Date) {
        apiDataManager.fetchAll(region: region, since: since) { result in
            switch result {
            case .success(let places):
                let annotations = places.map { PlaceAnnotation(from: $0, lifespanSince: since) }
                self.presenter?.present(places: annotations)
            case .failure(let error):
                self.presenter?.show(error: error)
            }
        }
    }

}

extension PlacesInteractorProtocol {

    private static func sinceDate(_ since: String) -> Date {
        return shortFormatter.date(from: since)!
    }

    func loadPlaces(region: RegionType, since: Date = sinceDate("1990")) {
        loadPlaces(region: region, since: since)
    }

}
