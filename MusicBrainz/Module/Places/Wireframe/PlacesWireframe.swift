//
//  PlacesWireframe.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

final class PlacesWireframe {
    
    var rootWireframe: RootWireframe?

    private weak var _view: PlacesView?

    private func prepareView() -> PlacesView {
        _view = .instantiate(name: "Places")
        let interactor = PlacesInteractor()
        let presenter = PlacesPresenter(interface: view, interactor: interactor, wireframe: self)

        view.presenter = presenter
        interactor.presenter = presenter

        return _view!
    }

    var view: PlacesView {
        return _view ?? prepareView()
    }

}

extension PlacesWireframe: PlacesWireframeProtocol {

    func presentPlacesModule(fromNavView view: UINavigationController) {
        view.pushViewController(self.view, animated: true)
    }

    func presentPlacesModule(fromView view: UIViewController) {
    }

    func presentPlacesModule(fromWindow window: UIWindow) {
        rootWireframe?.showRootViewController(view, inWindow: window)
    }

    func presentAlert(from error: Error) {
        view.showAlert(
            title: "Error",
            message: error.localizedDescription,
            okayButtonTitle: "OK",
            buttonAction: {}
        )
    }

}
