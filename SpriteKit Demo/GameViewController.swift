//
//  GameViewController.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 18/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import UIKit
import SpriteKit

extension SceneWithNavigation {
    func setupDefaultBackground() {
        self.backgroundColor = SKColor.grayColor()
    }
    
    func moveTo(scene: SceneWithNavigation) {
        self.view?.presentScene(scene)
    }
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = InitialScene(size: view.bounds.size)
        let skView = self.view as SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true
        
        scene.scaleMode = .AspectFill 
        
        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
