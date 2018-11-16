//
//  TutorialCoordinator.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

protocol TutorialCoordinatorDelegate: class {
    func tutorialCoordinatorDidComplete(_ coordinator: TutorialCoordinator)
}

class TutorialCoordinator {

    weak var delegate: TutorialCoordinatorDelegate?
    
    private let window: UIWindow
    private let locationManager: LocationManager
    
    init(_ window: UIWindow, locationManager: LocationManager) {
        self.window = window
        self.locationManager = locationManager
    }
    
    func start() {
        window.rootViewController = TutorialFirstViewController(locationManager: locationManager, delegate: self)
    }
}

//MARK: - TutorialFirstViewControllerDelegate
extension TutorialCoordinator: TutorialFirstViewControllerDelegate {
    
    func tutorialFirstViewControllerDidComplete(_ viewController: TutorialFirstViewController) {
        window.rootViewController = TutorialSecondViewController(delegate: self)
    }
}

//MARK: - TutorialSecondViewControllerDelegate
extension TutorialCoordinator: TutorialSecondViewControllerDelegate {
    
    func tutorialSecondViewControllerDidComplete(_ viewController: TutorialSecondViewController) {
        delegate?.tutorialCoordinatorDidComplete(self)
    }
}

