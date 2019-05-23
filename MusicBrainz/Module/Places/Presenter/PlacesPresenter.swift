//
//  PlacesPresenter.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit
import MapKit

final class PlacesPresenter {

    weak private var view: PlacesViewProtocol?
    private let interactor: PlacesInteractorProtocol
    private let wireframe: PlacesWireframeProtocol

    init(interface: PlacesViewProtocol, interactor: PlacesInteractorProtocol, wireframe: PlacesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.presenter = self
    }

}

extension PlacesPresenter: PlacesPresenterInputProtocol {

    func load() {
        interactor.loadRegion()
    }

    private func loadPlaces(region: RegionType) {
        interactor.loadPlaces(region: region)
    }

}

extension PlacesPresenter: PlacesPresenterOutputProtocol {

    func present(region: RegionType) {
        loadPlaces(region: region)
        view?.present(region: region)
    }

    func present(places: [PlaceAnnotation]) {
        for place in places {
            view?.add(place: place)

            Timer.scheduledTimer(withTimeInterval: TimeInterval(place.lifespan ?? 0), repeats: false) { [view] _ in
                view?.remove(place: place)
            }
        }
    }

    func show(error: Error) {
        wireframe.presentAlert(from: error)
    }

}
