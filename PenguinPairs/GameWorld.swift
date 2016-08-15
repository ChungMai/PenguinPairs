//
//  GameWorld.swift
//  PenguinPairs
//
//  Created by Home on 8/14/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class GameWorld : SKNode {
    
    var size = CGSize()
    var levelButtons = SKNode()
    var backgroundOption = SKSpriteNode(imageNamed: "spr_background_options")
    let onOffLabel = SKLabelNode(fontNamed: "Helvetica")
    let onOffButton = OnOffButton()
    let musicSlider = Slider()
    
    // initializers
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
//        let nrCols = 6, nrLevels = 12
//        var nrRows = nrLevels / nrCols
//        if nrLevels % nrCols != 0 {
//            nrRows += 1
//        }
//        let layout = GridLayout(rows: nrRows, columns: nrCols, cellWidth: 150, cellHeight: 150)
//        layout.xPadding = 5
//        layout.yPadding = 5
//        layout.target = levelButtons
//        
//        /* The original C-style for statement is deprecated. You can achieve the same thing
//         by using a range and reversing it, as illustrated below */
//        for i in (0..<nrRows).reverse() {
//            for j in 0..<nrCols {
//                if i*nrCols + j < nrLevels {
//                    let level = SKSpriteNode(imageNamed: "spr_level_unsolved")
//                    level.zPosition = Layer.Scene
//                    layout.add(level)
//                } else {
//                    layout.add(SKNode())
//                }
//            }
//        }
//        
//        self.addChild(levelButtons)
        
        let background = SKSpriteNode(imageNamed: "spr_background_levelselect")
        background.zPosition = Layer.Background
        self.addChild(background)
        
        backgroundOption.zPosition = Layer.Background
        self.addChild(backgroundOption)
        
        onOffLabel.horizontalAlignmentMode = .Right
        onOffLabel.verticalAlignmentMode = .Center
        onOffLabel.position = CGPoint(x: -50, y: 50)
        onOffLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        onOffLabel.fontSize = 60
        onOffLabel.text = "Hints"
        self.addChild(onOffLabel)
        
        
        onOffButton.position = CGPoint(x: 200, y: 50)
        self.addChild(onOffButton)
        
        let musicLabel = SKLabelNode(fontNamed: "Helvetica")
        musicLabel.horizontalAlignmentMode = .Right
        musicLabel.verticalAlignmentMode = .Center
        musicLabel.position = CGPoint(x: -50, y: -100)
        musicLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        musicLabel.fontSize = 60
        musicLabel.text = "Music volume"
        self.addChild(musicLabel)
        
        musicSlider.position = CGPoint(x:200, y:-100)
        self.addChild(musicSlider)
        musicSlider.value = 0.5
    }
    
    override func handleInput(inputHelper: InputHelper) {
        self.onOffButton.handleInput(inputHelper)
        self.musicSlider.handleInput(inputHelper)
    }
}
