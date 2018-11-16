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
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = TutorialFirstViewController(delegate: self)
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

