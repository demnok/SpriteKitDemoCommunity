//
//  FourthScene.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 22/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class FourthScene: SceneWithNavigation, SKPhysicsContactDelegate {
    
    var _triangle: SKSpriteNode!
    var _square: SKSpriteNode!
    var _shuriken: SKSpriteNode!
    
    var _ok: Int = 1
    
    var _reverseGravityButton: SKSpriteNode!
    var _changeNodeInteractionButton: SKSpriteNode!
    
    let _spriteSize = CGSize(width: 60.0, height: 60.0)
    
    override func didMoveToView(view: SKView) {
        navigationController = NavigationController(scene: self)
        navigationController.populateWithControls()
        
        previousScene = ThirdScene(size: view.bounds.size)
        nextScene = FifthScene(size: view.bounds.size)
        
        navigationDelegate = navigationController
        setupDefaultBackground()
        
        setupSprites()
        setupPhysicsWorld()
        setupShurikenButtons()
    }
    
    func setupPhysicsWorld() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    }
    
    func setupSprites() {
        
        let spriteHeight = CGRectGetMaxY(frame) - _spriteSize.height
        
        let widthRange = SKRange(lowerLimit: CGRectGetMinX(frame) + CGFloat(30), upperLimit: CGRectGetMaxX(frame) - CGFloat(30))
        let heightRange = SKRange(lowerLimit: CGRectGetMinY(frame) + CGFloat(30), upperLimit: CGRectGetMaxY(frame) - CGFloat(30))
        let spriteConstraint = SKConstraint.positionX(widthRange, y: heightRange)
        
        var constraintArray = NSArray(array: [spriteConstraint])
        
        
        _triangle = SKSpriteNode(imageNamed: "triangle")
        _square = SKSpriteNode(imageNamed: "blueSquare")
        
        _shuriken = SKSpriteNode(imageNamed: "Shuriken")
        _shuriken.name = "shuriken"
        
        _triangle.size = _spriteSize
        _square.size = _spriteSize
        _shuriken.size = _spriteSize
        
        _triangle.physicsBody = SKPhysicsBody(texture: _triangle.texture, size: _triangle.frame.size)
        _square.physicsBody = SKPhysicsBody(rectangleOfSize: _square.size)
        _shuriken.physicsBody = SKPhysicsBody(texture: _shuriken.texture, size: _shuriken.frame.size)
        
        _triangle.physicsBody?.categoryBitMask = 1 << UInt32(1)
        _square.physicsBody?.categoryBitMask = 1 << UInt32(2)
        
        _shuriken.physicsBody?.categoryBitMask = 1 << UInt32(1)
        _shuriken.physicsBody?.contactTestBitMask = 1 << UInt32(1)
        
        _triangle.position = CGPoint(x: CGRectGetMinX(frame) +  _triangle.size.width, y: spriteHeight)
        _square.position = CGPoint(x: CGRectGetMidX(frame), y: spriteHeight)
        _shuriken.position = CGPoint(x: CGRectGetMaxX(frame) - _shuriken.size.width, y: spriteHeight)
        
        _triangle.constraints = constraintArray
        _square.constraints = constraintArray
        _shuriken.constraints = constraintArray
        
        addChild(_triangle)
        addChild(_square)
        addChild(_shuriken)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == contact.bodyB.node?.name {
            var emitter = SKEmitterNode(fileNamed: "SmokeEffect.sks")
            
            emitter.position = contact.contactPoint

            let illustrateContact = SKAction.sequence([
                SKAction.runBlock({self.addChild(emitter)}),
                SKAction.waitForDuration(NSTimeInterval(0.1)),
                SKAction.runBlock({emitter.particleBirthRate = 0}),
                SKAction.waitForDuration(NSTimeInterval(emitter.particleLifetimeRange + 0.1)),
                SKAction.runBlock({emitter.removeFromParent()})
                ])
            
            runAction(illustrateContact)
        }
    }
    
    func setupShurikenButtons() {
        _reverseGravityButton = SKSpriteNode(imageNamed: "Shuriken")
        
        _changeNodeInteractionButton = SKSpriteNode(imageNamed: "Shuriken")
        _changeNodeInteractionButton.name = "shuriken"
        
        _changeNodeInteractionButton.size = _spriteSize
        _reverseGravityButton.size = _spriteSize
        
        _changeNodeInteractionButton.physicsBody = SKPhysicsBody(texture: _changeNodeInteractionButton.texture, size: _changeNodeInteractionButton.frame.size)
        _reverseGravityButton.physicsBody = SKPhysicsBody(texture: _reverseGravityButton.texture, size: _reverseGravityButton.frame.size)

        _changeNodeInteractionButton.physicsBody?.categoryBitMask = 1 << UInt32(1)
        _changeNodeInteractionButton.physicsBody?.contactTestBitMask = 1 << UInt32(1)
        
        _reverseGravityButton.physicsBody?.categoryBitMask = 1 << UInt32(1)
        
        _reverseGravityButton.position = CGPoint(x: CGRectGetMinX(frame) + 40, y: CGRectGetMidY(frame))
        _changeNodeInteractionButton.position = CGPoint(x: CGRectGetMaxX(frame) - 40, y: CGRectGetMidY(frame))
        
        _reverseGravityButton.physicsBody?.dynamic = false
        _changeNodeInteractionButton.physicsBody?.dynamic = false
        
        addChild(_changeNodeInteractionButton)
        addChild(_reverseGravityButton)
    }
    
    func reverseGravity() {
        if _ok == 1 {
            physicsWorld.gravity = CGVector(dx: 0.0, dy: 9.8)
            _ok = 0
        } else {
            physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
            _ok = 1
        }
    }
    
    func makeCustomPhysicsBodyPassThrough() {
        _changeNodeInteractionButton.physicsBody?.collisionBitMask = 0
        _triangle.physicsBody?.collisionBitMask = 0
    }
    

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if CGRectContainsPoint(_reverseGravityButton.frame, location){
                reverseGravity()
            }
            
            if CGRectContainsPoint(_changeNodeInteractionButton.frame, location) {
                makeCustomPhysicsBodyPassThrough()
            }
            
            if CGRectContainsPoint(nextButton.frame, location) {
                if let scene = nextScene {
                    moveTo(scene)
                } else {
                    navigationDelegate.didReceiveError()
                }
            }
            
            if CGRectContainsPoint(previousButton.frame, location) {
                if let scene = previousScene {
                    moveTo(scene)
                } else {
                    navigationDelegate.didReceiveError()
                }
            }
        }
    }

}
