//
//  LoginView.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class LoginView: UIViewController, LoginViewProtocol {

	var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    //MARK:- IBActions
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        print("hello")
        
        loginSuccessful()
    }
    
    func loginSuccessful(){
        self.presenter?.showHomeScreen()
    }
    
}


