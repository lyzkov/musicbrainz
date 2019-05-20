//
//  LoginPresenter.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {

    weak private var view: LoginViewProtocol?
    private let interactor: LoginInteractorInputProtocol
    private let wireframe: LoginWireframeProtocol

    init(interface: LoginView, interactor: LoginInteractorInputProtocol, wireframe: LoginWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.presenter = self
    }

    func showHomeScreen() {
        self.wireframe.loadHomeScreenWireframe()
    }
}
