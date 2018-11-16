//
//  TutorialSecondViewController.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import UIKit

protocol TutorialSecondViewControllerDelegate: class {
    func tutorialSecondViewControllerDidComplete(_ viewController: TutorialSecondViewController)
}

class TutorialSecondViewController: BaseViewController {

    weak var delegate: TutorialSecondViewControllerDelegate?
    
    convenience init(delegate: TutorialSecondViewControllerDelegate?) {
        self.init()
        self.delegate = delegate
    }

    @IBAction private func okButtonTap(_ sender: Any) {
        delegate?.tutorialSecondViewControllerDidComplete(self)
    }
}
