//
//  TutorialFirstViewController.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

protocol TutorialFirstViewControllerDelegate: class {
    func tutorialFirstViewControllerDidComplete(_ viewController: TutorialFirstViewController)
}

class TutorialFirstViewController: BaseViewController {

    weak var delegate: TutorialFirstViewControllerDelegate?
    
    convenience init(delegate: TutorialFirstViewControllerDelegate?) {
        self.init()
        self.delegate = delegate
    }
    
    @IBAction private func nextButtonTap(_ sender: Any) {
        delegate?.tutorialFirstViewControllerDidComplete(self)
    }
}
