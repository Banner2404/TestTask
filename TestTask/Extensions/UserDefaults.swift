//
//  UserDefaults.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var isTutorialComplete: Bool {
        return bool(forKey: Keys.tutorialMark)
    }
    
    func setTutorialComplete() {
        set(true, forKey: Keys.tutorialMark)
    }
    
    private struct Keys {
        static let tutorialMark = "tutorialMark"
    }
}
