//
//  AppDependencies.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

final class AppDependencies {

    static let shared = AppDependencies()
    
    let rootWireframe = RootWireframe()

    let placesWireframe = PlacesWireframe()

    init() {
        configureDependencies()
    }

    func installRootViewController(into window: UIWindow) {
        placesWireframe.presentPlacesModule(fromWindow: window)
    }

    func configureDependencies() {
        placesWireframe.rootWireframe = rootWireframe
    }
    
}
