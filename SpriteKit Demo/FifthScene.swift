//
//  FifthScene.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 22/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class FifthScene: FourthScene {
    override func didBeginContact(contact: SKPhysicsContact) {
        
    }
    
    func checkForErrors() {
        enumerateChildNodesWithName("error", usingBlock: { (node, stop) -> Void in
            println(node)
        })
    }
    
//    override func update(currentTime: NSTimeInterval) {
//        checkForErrors()
//        println(currentTime)
//        navigationDelegate.didReceiveError()
//    }
//    
//    override func didEvaluateActions() {
//       checkForErrors()
//    }
//    
//    override func didSimulatePhysics() {
//        navigationDelegate.didReceiveError()
//    }
//
//    override func didFinishUpdate() {
//        checkForErrors()
//    }
    
    override func didApplyConstraints() {
        if _square.position.y < 31 {
            _square.physicsBody?.dynamic = false
        }
        else if _square.position.y > CGRectGetMaxY(frame) - 31 {
            _square.physicsBody?.dynamic = false
        }
        
        if _square.position.x < 31 {
            _square.physicsBody?.dynamic = false
        }
        else if _square.position.x > CGRectGetMaxX(frame) - 31{
            _square.physicsBody?.dynamic = false
        }
    }
    
}
