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
    private let locationManager: LocationManager
    @IBOutlet private weak var nextButton: UIButton!
    
    init(locationManager: LocationManager, delegate: TutorialFirstViewControllerDelegate?) {
        self.locationManager = locationManager
        super.init()
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateAuthorization), name: .locationManagerDidUpdateAuthorization, object: nil)
        locationManager.requestAuthorizationIfNeeded()
        updateNextButton()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction private func nextButtonTap(_ sender: Any) {
        delegate?.tutorialFirstViewControllerDidComplete(self)
    }
    
    @objc
    private func didUpdateAuthorization() {
        updateNextButton()
    }
    
    private func updateNextButton() {
        nextButton.isEnabled = locationManager.authorizationStatus == .authorizedWhenInUse
    }
}
