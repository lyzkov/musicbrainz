//
//  PlacesWireframeSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
@testable import MusicBrainz

final class PlacesWireframeSpy: PlacesWireframeProtocol {

    var rootWireframe: RootWireframe?

    func presentPlacesModule(fromWindow window: UIWindow) {

    }

    func presentPlacesModule(fromNavView view: UINavigationController) {

    }

    func presentPlacesModule(fromView view: UIViewController) {

    }

    var didPresentAlertError: Error?

    func presentAlert(from error: Error) {
        didPresentAlertError = error
    }

}
