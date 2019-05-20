//
//  AppDependencies.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

class AppDependencies {
    
    let rootWireframe = RootWireframe()
    
    let sidePanelWireframe = SidePanelWireframe()
    let loginWireFrame = LoginWireframe()
    let homeWireframe = HomeWireframe()
    let settingsWireframe = SettingsWireframe()

    static let shared = AppDependencies()
    
    
    init() {
        configureDependencies()
    }
    
    
    /// Function to initialize root view controller of the app
    ///
    /// - Parameter window: UIWindow
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        // TODO: Which module is going to be presented?
        
        loginWireFrame.presentLoginModule(fromWindow: window)
    }
    
    
    
    func configureDependencies() {
        
        // ----------------------------------------------------------------
        //   configuring wireframe dependencies
        // ----------------------------------------------------------------
        
        //login wireframe
        loginWireFrame.rootWireframe = rootWireframe
        loginWireFrame.homeWireframe = homeWireframe
        loginWireFrame.sidePanelWireframe = sidePanelWireframe
        
        //sidepanel wireframe
        sidePanelWireframe.rootWireframe = rootWireframe
        sidePanelWireframe.loginWireframe = loginWireFrame
        
        //home wireframe
        homeWireframe.rootWireframe = rootWireframe
        
        //settings wireframe
        settingsWireframe.rootWireframe = rootWireframe

    }
    
    
}

