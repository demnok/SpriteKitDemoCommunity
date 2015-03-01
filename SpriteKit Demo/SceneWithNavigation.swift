//
//  SceneWithNavigation.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 20/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class SceneWithNavigation: SKScene {
    var nextButton: SKLabelNode!
    var previousButton: SKLabelNode!
    
    let navigationErrorMessage = "Scene can not be displayed"
    
    var nextScene: SceneWithNavigation!
    var previousScene: SceneWithNavigation!
    
    var navigationDelegate: NavigationControllerDelegate!
    var navigationController: NavigationController!

    
}
