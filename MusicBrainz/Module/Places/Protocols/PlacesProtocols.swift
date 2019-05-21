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
    func show(error: Error)
}

// MARK: - Interactor

protocol PlacesInteractorProtocol: class {
    var presenter: PlacesPresenterOutputProtocol?  { get set }
//    var apiDataManager: PlacesAPIDataManagerInputProtocol { get }
//    var locationDataManager: PlacesLocationDataManagerInputProtocol { get }
    func loadRegion()
}

// MARK: - DataManager

protocol PlacesDataManagerInputProtocol: class {
}

protocol PlacesAPIDataManagerInputProtocol: class {
}

protocol PlacesLocationDataManagerInputProtocol: class {
    func location(completion: @escaping (Result<LocationType, Error>) -> Void)
    func region(completion: @escaping (Result<RegionType, Error>) -> Void)
}
