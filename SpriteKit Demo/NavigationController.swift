//
//  NavigationController.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 19/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class NavigationController: NavigationControllerDelegate {
    private var _currentScene: SceneWithNavigation!
    private var _frame: CGRect!
    
    private var _nextButton: SKLabelNode!
    private var _previousButton: SKLabelNode!
    
    private let _navigationErrorMessage = "Scene can not be displayed"
    
    init(scene: SceneWithNavigation) {
        _currentScene = scene
        _frame = _currentScene.frame
    }
    
    
    func didReceiveError() {
        displayNavigationErrorLabel()
    }
    
    func populateWithControls() {
        addPreviousButton()
        addNextButton()
    }
    
    private func addNextButton() {
        _nextButton = SKLabelNode(fontNamed: "System")
        
        _nextButton.fontSize = 20
        _nextButton.text = "Next"
        
        let xPos = CGRectGetMaxX(_frame) - 20
        let yPos = CGRectGetMinY(_frame) + 2 * _nextButton.frame.height
        _nextButton.position = CGPoint(x: xPos, y: yPos)
        
        _currentScene.nextButton = _nextButton
        _currentScene.addChild(_currentScene.nextButton)
    }
    
    private func addPreviousButton() {
        _previousButton = SKLabelNode(fontNamed: "System")
        
        _previousButton.fontSize = 20
        _previousButton.text = "Previous"
        
        let xPos = CGRectGetMinX(_frame) + 40
        let yPos = CGRectGetMinY(_frame) + 2 * _previousButton.frame.height
        _previousButton.position = CGPoint(x: xPos, y: yPos)
        
        _currentScene.previousButton = _previousButton
        _currentScene.addChild(_currentScene.previousButton)
    }

    private func displayNavigationErrorLabel() {
        let errorLabel = SKLabelNode(text: _navigationErrorMessage)
        
        errorLabel.fontName = "System"
        errorLabel.fontSize = 20
        
        errorLabel.position = CGPoint(x: CGRectGetMidX(_frame), y: CGRectGetMidY(_frame))
        errorLabel.name = "error"
        
        let smokeParticle = SKEmitterNode(fileNamed: "SmokeEffect.sks")
        let birthRate = smokeParticle.particleBirthRate
        
        smokeParticle.position = errorLabel.position
        
        let spawnNodeDuo = SKAction.group([
            SKAction.runBlock{self._currentScene.addChild(smokeParticle)},
            SKAction.runBlock{self._currentScene.addChild(errorLabel)}
            ])
        
        let despawnGroup = SKAction.group([
            SKAction.runBlock{errorLabel.removeFromParent()},
            SKAction.runBlock{smokeParticle.removeFromParent()}
            ])
        
        let smokeEffectSequence = SKAction.sequence([
            SKAction.waitForDuration(NSTimeInterval(0.1)),
            SKAction.runBlock{smokeParticle.particleBirthRate = 0},
            SKAction.waitForDuration(NSTimeInterval(smokeParticle.particleLifetime + 0.1)),
            ])
        
        _currentScene.runAction(SKAction.sequence([
            spawnNodeDuo,
            smokeEffectSequence,
            despawnGroup
            ])
        )
    }

}