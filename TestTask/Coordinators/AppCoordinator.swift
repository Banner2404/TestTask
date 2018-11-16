//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    
    private let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = TutorialFirstViewController(delegate: self)
    }
}

//MARK: - TutorialFirstViewControllerDelegate
extension AppCoordinator: TutorialFirstViewControllerDelegate {
    
    func tutorialFirstViewControllerDidComplete(_ viewController: TutorialFirstViewController) {
        window.rootViewController = TutorialSecondViewController(delegate: self)
    }
}

//MARK: - TutorialSecondViewControllerDelegate
extension AppCoordinator: TutorialSecondViewControllerDelegate {
    
    func tutorialSecondViewControllerDidComplete(_ viewController: TutorialSecondViewController) {
        
    }
}
