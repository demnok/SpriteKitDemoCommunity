//
//  ThirdScene.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 22/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class ThirdScene: SceneWithNavigation {
    
    var _rotate: SKAction!
    var _moveTo: SKAction!
    var _fadeAlphaTo: SKAction!
    var _scaleBy: SKAction!
    var _scaleXBy: SKAction!
    
    var _basicNodes: Array<SKSpriteNode> = []
    var _basicActions: Array<SKAction> = []
    var _basicActionNames = ["Rotate", "MoveTo", "Fade", "ScaleBy", "ScaleXBy"]
    
    var _complexNode: SKSpriteNode!
    var _centerPosition: CGPoint!
    
    var _reloadButton: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        navigationController = NavigationController(scene: self)
        navigationController.populateWithControls()
        
        previousScene = SecondScene(size: view.bounds.size)
        nextScene = FourthScene(size: view.bounds.size)
        
        navigationDelegate = navigationController
        setupDefaultBackground()
    
        _centerPosition = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))

        
        initialiseActions()
        constructBasicActionsSprites()
        addLabelsUnderBasicNodes()
        
        addReloadButton()
        
        addComplexActionSprite()
    }
    
    func addComplexActionSprite() {
        _complexNode = SKSpriteNode(imageNamed: "spriteKit")
        _complexNode.size = CGSize(width: 80.0, height: 80.0)
        
        _complexNode.position = _centerPosition
        addChild(_complexNode)
    }
    
    func moveAction(destinationNode: SKSpriteNode) -> SKAction {
        var moveAction: SKAction
        
        var moveToDestinationGroup = SKAction.group([
            SKAction.moveTo(destinationNode.position, duration: 1),
            SKAction.scaleBy(CGFloat(1.5), duration: 0.5)
            ])
        
        var moveFromDestinationGroup = SKAction.group([
            SKAction.moveTo(_centerPosition, duration: 1),
            SKAction.scaleBy(CGFloat(0.66), duration: 0.5)
            ])
        
        moveAction = SKAction.sequence([
            moveToDestinationGroup,
            moveFromDestinationGroup
            ])
        
        return moveAction
    }
    
    func addReloadButton() {
        _reloadButton = SKSpriteNode(imageNamed: "reload")
        _reloadButton.position = CGPoint(x: CGRectGetMinX(frame) + 25, y: CGRectGetMidY(frame))
        
        addChild(_reloadButton)
    }
    
    func initialiseActions() {
        _basicActions.append(SKAction.rotateByAngle(CGFloat(M_PI), duration: 1.0))
        _basicActions.append(SKAction.moveTo(CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)), duration: 1.0))
        _basicActions.append(SKAction.fadeAlphaTo(CGFloat(0.75), duration: 1.0))
        _basicActions.append(SKAction.scaleBy(CGFloat(2.0), duration: 1.0))
        _basicActions.append(SKAction.scaleXBy(CGFloat(1.5), y: CGFloat(0.5), duration: 1.0))
    }
    
    func addLabelsUnderBasicNodes() {
        for i in 0..<5 {
            var basicActionNameLabel = SKLabelNode(text: _basicActionNames[i])
            basicActionNameLabel.fontSize = 12
            basicActionNameLabel.fontName = "System"
            
            basicActionNameLabel.position = CGPoint(x: _basicNodes[i].position.x, y: _basicNodes[i].position.y - _basicNodes[i].frame.height)
            
            addChild(basicActionNameLabel)
        }
    }
    
    func constructBasicActionsSprites() {
        for i in 1...5 {
            var sprite = SKSpriteNode(imageNamed: "spriteKit")
            sprite.size = CGSize(width: 40.0, height: 40.0)
            
            sprite.position = CGPoint(x: CGRectGetMaxX(frame) *  CGFloat(0.16 * CGFloat(i)), y: CGRectGetMaxY(frame) - CGFloat(50))
            
            sprite.name = "basic"
            sprite.alpha = 0
            sprite.runAction(SKAction.sequence([
                SKAction.waitForDuration(0.5),
                SKAction.fadeAlphaTo(CGFloat(1), duration: 0.6)
                ])
            )
            
            _basicNodes.append(sprite)
            addChild(sprite)
        }
    }
    
    func deconstructBasicActionSprites() {
        enumerateChildNodesWithName("basic", usingBlock: { (node, stop) -> Void in
            node.runAction(SKAction.sequence([
                SKAction.fadeAlphaTo(CGFloat(0), duration: 0.3),
                SKAction.removeFromParent()
                ])
            )
        })
        
        _basicNodes = []
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if CGRectContainsPoint(_complexNode.frame, location) {
                let destinationNode = _basicNodes[2]
                _complexNode.runAction(moveAction(destinationNode))
            }
            
            if CGRectContainsPoint(_reloadButton.frame, location) {
                deconstructBasicActionSprites()
                constructBasicActionsSprites()
            }
            
            for i in 0..<5 {
                if CGRectContainsPoint(_basicNodes[i].frame, location) {
                    _basicNodes[i].runAction(_basicActions[i])
                }
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
