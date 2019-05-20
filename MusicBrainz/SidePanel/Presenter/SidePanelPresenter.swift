//
//  SidePanelPresenter.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class SidePanelPresenter: SidePanelPresenterProtocol {

    weak private var view: SidePanelViewProtocol?
    private let interactor: SidePanelInteractorInputProtocol
    private let wireframe: SidePanelWireframeProtocol

    init(interface: SidePanelView, interactor: SidePanelInteractorInputProtocol, wireframe: SidePanelWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.presenter = self
    }
    
    func presentLoginScreen() {
        self.wireframe.presentLoginScreen()
    }
    
    func showScreenWith(controller: UIViewController) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate!.window
        
        self.wireframe.presentSidePanelControllerModule(fromWindow: window!, rootViewController: controller)
    }
    
    func logoutUser() {
        
    }
    
    func logoutUserFailedWith(error: String) {
        
    }
    
    func logoutUserSuccessful() {
        
    }


}
