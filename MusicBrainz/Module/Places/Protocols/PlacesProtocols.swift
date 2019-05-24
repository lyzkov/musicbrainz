//
//  PlacesProtocols.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit
import MapKit

// MARK: - View

protocol PlacesViewProtocol: class {
    var presenter: PlacesPresenterInputProtocol?  { get set }
    func present(region: RegionType)
    func add(place: PlaceAnnotation)
    func remove(place: PlaceAnnotation)
}

// MARK: - Wireframe

protocol PlacesWireframeProtocol: class {
    var rootWireframe: RootWireframe? { get set }
    func presentPlacesModule(fromWindow window: UIWindow)
    func presentPlacesModule(fromNavView view: UINavigationController)
    func presentPlacesModule(fromView view: UIViewController)
    func presentAlert(from error: Error)
}

// MARK: - Presenter

protocol PlacesPresenterInputProtocol: class {
    func load()
}

protocol PlacesPresenterOutputProtocol: class {
    func present(region: RegionType)
    func present(places: [PlaceAnnotation])
    func show(error: Error)
}

// MARK: - Interactor

protocol PlacesInteractorProtocol: class {
    var presenter: PlacesPresenterOutputProtocol?  { get set }
    func loadRegion()
    func loadPlaces(region: RegionType, since: Date)
}

// MARK: - DataManager

protocol PlacesDataManagerInputProtocol: class {
}

protocol PlacesAPIDataManagerInputProtocol: class {
    func fetch(region: RegionType, since: Date, offset: Int, limit: Int,
               completion: @escaping (Result<[Place], Error>) -> Void)
    func fetchAll(region: RegionType, since: Date, completion: @escaping (Result<[Place], Error>) -> Void)
}

protocol PlacesLocationDataManagerInputProtocol: class {
    func location(completion: @escaping (Result<LocationType, Error>) -> Void)
    func region(completion: @escaping (Result<RegionType, Error>) -> Void)
}
