//
//  SecondScene.swift
//  SpriteKit Demo
//
//  Created by Stolniceanu Stefan on 20/02/15.
//  Copyright (c) 2015 Stefan Stolniceanu. All rights reserved.
//

import SpriteKit

class SecondScene: SceneWithNavigation {
    
    private var _video: SKVideoNode!
    private var _effect: SKEffectNode!
    
    override func didMoveToView(view: SKView) {
        navigationController = NavigationController(scene: self)
        navigationController.populateWithControls()
        
        navigationDelegate = navigationController
        setupDefaultBackground()
        
        previousScene = InitialScene(size: view.bounds.size)
        nextScene = ThirdScene(size: view.bounds.size)
        
        setupVideoNode()
        applyEffectNode()
        cropTheVideoNodeByEclipse()
    }
    
    
    func setupVideoNode() {
        _video = SKVideoNode(videoFileNamed: "videoForNode.mp4")
        
        _video.size = CGSize(width: 400, height: 200)
        
        _video.zRotation = CGFloat(-M_PI_2)
        _video.play()
    }
    
    func cropTheVideoNodeByEclipse() {
        let eclipse = SKShapeNode(circleOfRadius: CGFloat(50))
        eclipse.lineWidth = 100
        
        let crop = SKCropNode()
        
        crop.maskNode = eclipse
        crop.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMaxY(frame) - 150)
        
        crop.addChild(_video)
        addChild(crop)
    }

    func applyEffectNode() {
        let sprite = SKSpriteNode(imageNamed: "spriteKit")
        
        sprite.size = CGSize(width: 200.0, height: 200.0)
        
        _effect = SKEffectNode()
        _effect.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMinY(frame) + 200)
        
        _effect.blendMode = SKBlendMode.Replace
        _effect.filter = CIFilter(name: "CIGaussianBlur")
        _effect.filter?.setDefaults()
        _effect.alpha = 1
        _effect.shouldEnableEffects = true
        _effect.addChild(sprite)
        addChild(_effect)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if CGRectContainsPoint(nextButton.frame, location) {
                if let scene = nextScene {
                    _video.pause()
                    moveTo(scene)
                } else {
                    navigationDelegate.didReceiveError()
                }
            }
            
            if CGRectContainsPoint(previousButton.frame, location) {
                if let scene = previousScene {
                    _video.pause()
                    moveTo(scene)
                } else {
                    navigationDelegate.didReceiveError()
                }
            }
        }
    }

}
