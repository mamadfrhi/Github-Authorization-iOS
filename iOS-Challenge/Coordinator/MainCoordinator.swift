//
//  MainCoordinator.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Moya

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.barTintColor = .blue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let kc = KeychainAPI()
        if kc.token != nil {
            search()
        }else {
            login()
        }
    }
    
    func search() {
        let searchVC = SearchController()
        searchVC.coordinator = self
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func userInfo() {
        let userVC = UserController(keychain: KeychainAPI())
        navigationController.present(userVC, animated: true)
    }
    
    func commits(url: String) {
        let commitsVC = CommitsController(url: url.commitsURLPath!)
        navigationController.pushViewController(commitsVC, animated: true)
    }
}

// MARK:- Login
extension MainCoordinator {
    func login() {
        let loginVC = LoginController.instantiate()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func openGithub() {
        let urlStr = "https://github.com/login/oauth/authorize"
        if let githubAuthURL = urlStr.githubURL {
            UIApplication.shared.open(githubAuthURL,
                                      options: [:])
        }
    }
    
    // Come from deep link
    func resumeAuthentication(with parameters: QueryParameters) {
        guard let loginVC = navigationController.topViewController as? LoginController else {
            return
        }
        loginVC.getAuthentication(with: parameters)
    }
}


