//
//  LevelMenuState.swift
//  PenguinPairs
//
//  Created by MacMini on 8/15/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class LevelMenuState : SKNode{
    var backButton = Button(imageNamed:"spr_button_back")
    var levelButtons = SKNode()
    var layout: GridLayout?
    var data = FileReader(fileNamed:"levels")
    var nrLevels = 0
    var quitButton = Button(imageNamed:"spr_button_quit")
    var animals = SKNode()
    
    // initializers
    init(nrLevels: Int) {
        super.init()
        self.nrLevels = Int(data.nextLine())!
        self.name = "level"
        
        let nrCols = 6
        var nrRows = nrLevels / nrCols
        if nrLevels % nrCols != 0 {
            nrRows += 1
        }
        layout = GridLayout(rows: nrRows, columns: nrCols, cellWidth: 150, cellHeight: 150)
        layout?.xPadding = 5
        layout?.yPadding = 5
        self.addChild(levelButtons)
        layout?.target = levelButtons
//
//        /* The original C-style for statement is deprecated. You can achieve the same thing
//         by using a range and reversing it, as illustrated below */
        for i in (0..<nrRows).reverse() {
            print("i:\(i)")
            for j in 0..<nrCols {
                //if i*nrCols + j + 1 <= nrLevels {
                    let level = LevelButton(levelIndex: i*nrCols + j + 1)
                    level.name = "levelButton\(i*nrCols + j + 1)"
                    level.zPosition = Layer.Scene
                    layout?.add(level)
//                } else {
//                    layout?.add(SKNode())
//                }
            }
        }
        
        let background = SKSpriteNode(imageNamed: "spr_background_levelselect")
        background.zPosition = Layer.Background
        self.addChild(background)
        backButton.zPosition = Layer.Scene
        backButton.position = CGPoint(x: 0, y: -320)
        self.addChild(backButton)
        
        quitButton.position = GameScreen.instance.topRight - quitButton.center - CGPoint(x:10,y:10)
        quitButton.zPosition = Layer.Overlay
        addChild(quitButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if backButton.tapped {
            GameStateManager.instance.switchTo("title")
        }
    }
    
    func findAnimalAtPosition(col:Int, row:Int) -> Animal?{
        for obj in animals.children{
            let animal = obj as! Animal
            let (currCol, currRow) = animal.currentBlock
            if currCol == col && currRow == row && animal.velocity == CGPoint.zero{
                return animal
            }
        }
        return nil
    }
}
