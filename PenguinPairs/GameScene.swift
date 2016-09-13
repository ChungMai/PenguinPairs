//
//  GameScene.swift
//  PenguinPairs
//
//  Created by Home on 8/14/16.
//  Copyright (c) 2016 Home. All rights reserved.
//

import SpriteKit

struct Layer {
    static let Background : CGFloat = 0
    static let Scene : CGFloat = 1
    static let Scene1 : CGFloat = 2
    static let Scene2 : CGFloat = 3
    static let Overlay : CGFloat = 10
    static let Overlay1 : CGFloat = 11
    static let Overlay2 : CGFloat = 12
}

class GameScene: SKScene {
    var delta: NSTimeInterval = 1/60
    
    var inputHelper = InputHelper()
    var touchmap: [UITouch:Int] = [UITouch:Int]()
    var loadingFrame = SKSpriteNode(imageNamed:"spr_frame_help")
    override init(size: CGSize) {
        super.init(size: size)
        GameScreen.instance.size = size
        
        loadingFrame.position = CGPoint(x: 0, y:0)
        loadingFrame.zPosition = Layer.Overlay2
        //self.addChild(loadingFrame)
        
        let loadingText = SKLabelNode(fontNamed: "Autodestruct")
        loadingText.position = CGPoint(x: 0, y: -20)
        loadingText.fontColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        loadingText.fontSize = 30
        loadingText.text = "LOADING..."
        loadingText.horizontalAlignmentMode = .Center
        loadingText.zPosition = Layer.Overlay
        
        loadingFrame.addChild(loadingText)
        
        // create the game states
        GameStateManager.instance.add(TitleMenuState())
        GameStateManager.instance.add(HelpState())
        GameStateManager.instance.add(OptionsMenuState())
        // add the levels
        
        
        let levels = FileReader(fileNamed:"levels")
        let levelNr = Int(levels.nextLine())!
        
        GameStateManager.instance.add(LevelMenuState(nrLevels:levelNr))
        for i in 1...levelNr{
            GameStateManager.instance.add(LevelState(fileReader: levels, levelNr: i))
        }
        
        GameStateManager.instance.switchTo("title")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(GameStateManager.instance)
        view.frameInterval = 2
        delta = NSTimeInterval(view.frameInterval) / 60
    }
    
    override func update(currentTime: NSTimeInterval) {
        GameStateManager.instance.handleInput(inputHelper)
        GameStateManager.instance.updateDelta(delta)
        inputHelper.reset()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            touchmap[touch] = inputHelper.touchBegan(location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let touchid = touchmap[touch]!
            inputHelper.touchMoved(touchid, loc: touch.locationInNode(self))
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let touchid = touchmap[touch]!
            touchmap[touch] = nil
            inputHelper.touchEnded(touchid)
        }
    }
}
