//
//  InitialScene.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 18/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class InitialScene: SceneWithNavigation {
    
    override func didMoveToView(view: SKView) {
        navigationController = NavigationController(scene: self)
        navigationController.populateWithControls()
 
        navigationDelegate = navigationController
        
        nextScene = SecondScene(size: view.bounds.size)
        
        setupDefaultBackground()
        
        addSquareSprite()
        addSquareShape()
        addRainAsBackground()
    }
    
    func addSquareSprite() {
        var squareSprite = SKSpriteNode(imageNamed: "blueSquare")
        squareSprite.alpha = 1
        
        let xPos = CGRectGetMidX(frame) - 2 * CGRectGetMaxX(squareSprite.frame)
        let yPos = CGRectGetMidY(frame)
        squareSprite.position = CGPoint(x: xPos, y: yPos)
        
        addChild(squareSprite)
    }
    
    func addSquareShape() {
        var squareShape = SKShapeNode(rectOfSize: CGSize(width: 40.0, height: 40.0))
        
        let xPos = CGRectGetMidX(frame) + 2 * CGRectGetMaxX(squareShape.frame)
        let yPos = CGRectGetMidY(frame)
        squareShape.position = CGPoint(x: xPos, y: yPos)
        
        squareShape.fillColor = SKColor.blueColor()
        squareShape.lineWidth = 0
        
        addChild(squareShape)
    }
    
    func addRainAsBackground() {
        var spriteKitRain = SKEmitterNode(fileNamed: "SpriteKitRain.sks")
        
        spriteKitRain.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMinY(frame))
        spriteKitRain.particlePositionRange.dx = CGRectGetMaxX(frame)
        
        addChild(spriteKitRain)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
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
