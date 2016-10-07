//
//  OptionsMenuState.swift
//  PenguinPairs
//
//  Created by MacMini on 8/15/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class OptionsMenuState : SKNode{
    var backButton = Button(imageNamed:"spr_button_back")
    var musicSlider = Slider()
    var onOffButton = OnOffButton()
    
    // initializers
    override init() {
        super.init()
        
        self.name = "options"
        
        let background = SKSpriteNode(imageNamed: "spr_background_options")
        background.zPosition = Layer.Background
        self.addChild(background)
        backButton.zPosition = Layer.Scene
        backButton.position = CGPoint(x: 0, y: -320)
        self.addChild(backButton)
        
        let onOffLabel = SKLabelNode(fontNamed: "Helvetica")
        onOffLabel.horizontalAlignmentMode = .right
        onOffLabel.verticalAlignmentMode = .center
        onOffLabel.position = CGPoint(x: -50, y: 50)
        onOffLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        onOffLabel.fontSize = 60
        onOffLabel.text = "Hints"
        self.addChild(onOffLabel)
        
        onOffButton.position = CGPoint(x: 200, y: 50)
        onOffButton.name = "OnOffHint"
        self.addChild(onOffButton)
        onOffButton.on = DefaultsManager.instance.hints
        
        let musicLabel = SKLabelNode(fontNamed: "Helvetica")
        musicLabel.horizontalAlignmentMode = .right
        musicLabel.verticalAlignmentMode = .center
        musicLabel.position = CGPoint(x: -50, y: -100)
        musicLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        musicLabel.fontSize = 60
        musicLabel.text = "Music volume"
        self.addChild(musicLabel)
        
        
        musicSlider.position = CGPoint(x: 200, y: -100)
        musicSlider.value = CGFloat(DefaultsManager.instance.musicVolume)
        self.addChild(musicSlider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(_ inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if backButton.tapped {
            GameStateManager.instance.switchTo("title")
        }
    }
    
    override func updateDelta(_ delta: TimeInterval) {
        super.updateDelta(delta)
        DefaultsManager.instance.hints = onOffButton.on
        DefaultsManager.instance.musicVolume = Float(musicSlider.value)
    }
}
