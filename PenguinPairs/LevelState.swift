//
//  LevelState.swift
//  PenguinPairs
//
//  Created by MacMini on 8/19/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class LevelState : SKNode{
    var levelNr = 0
    var animals = SKNode()
    var lines : [String] = []
    var quitButton = Button(imageNamed:"spr_button_quit")
    var retryButton = Button(imageNamed:"spr_button_retry")
    var hintButton = Button(imageNamed:"spr_button_hint")
    let hintVisibleAction = SKAction.sequence([SKAction.unhide(),SKAction.waitForDuration(1), SKAction.hide()])
    var hint = SKSpriteNode()
    var firstMoveMade = false
    
    init(fileReader: FileReader, levelNr : Int){
        super.init()
        
        quitButton.zPosition = Layer.Overlay
        quitButton.position = GameScreen.instance.topRight
        quitButton.position.x -= quitButton.center.x + 10
        quitButton.position.y -= quitButton.center.y + 10
        self.addChild(quitButton)
        
        retryButton.zPosition = Layer.Overlay
        retryButton.position.x = quitButton.position.x - quitButton.size.width - 10
        retryButton.position.y = quitButton.position.y
        self.addChild(retryButton)
        retryButton.hidden = true
        
        hintButton.zPosition = Layer.Overlay
        hintButton.position = retryButton.position
        self.addChild(hintButton)
        
        self.levelNr = levelNr
        self.name = "level\(levelNr)"
        let background = SKSpriteNode(imageNamed: "spr_background_level")
        background.zPosition = Layer.Background
        self.addChild(background)
        
        let _ = fileReader.nextLine()
        let _ = fileReader.nextLine()
        let nrPairs = Int(fileReader.nextLine())!
        let sizeArr = fileReader.nextLine().componentsSeparatedByString(" ")
        let width = Int(sizeArr[0])!, height = Int(sizeArr[1])!
        let hintArr = fileReader.nextLine().componentsSeparatedByString(" ")
        
        
        let tileDimension = 75
        let tileField = TileField(rows: height, columns: width, cellWidth: tileDimension, cellHeight: tileDimension)
        tileField.name = "tileField"
        self.addChild(tileField)
        
        for _ in 0..<height{
            var newLine = fileReader.nextLine()
            while newLine.characters.count < width{
                newLine += " "
            }
            lines.append(newLine)
        }
        
        for i in 0..<height{
            let currline = lines[height-1-i]
            var  j = 0
            for c in currline.characters{
                j += 1
                switch c {
                case ".":
                    let tileSprite = "spr_field_\((i + j) % 2)"
                    let tile = Tile(imageNamed:tileSprite, type: TileType.Normal)
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                case " ":
                    let tile = Tile()
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                case "r", "b", "g", "o", "p", "y", "m", "x", "s", "@", "R", "B", "G", "O", "P", "Y", "M", "X":
                    let tileSprite = "spr_field_\((i + j) % 2)"
                    let tile = Tile(imageNamed: tileSprite, type: .Normal)
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                    let p = Animal(type: String(c))
                    p.position = tile.position
                    p.initialPosition = tile.position
                    p.zPosition = Layer.Scene1
                    animals.addChild(p)
                default:
                    let tile = Tile(imageNamed: "spr_wall", type: .Wall)
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                }
            }
        }
        self.addChild(animals)
        
        // animal selector
        let animalSelector = AnimalSelector(spacing: tileDimension)
        animalSelector.name = "animalSelector"
        animalSelector.zPosition = Layer.Scene2
        self.addChild(animalSelector)
        
        // pair list
        let goalFrame = SKSpriteNode(imageNamed: "spr_frame_goal")
        goalFrame.zPosition = Layer.Overlay
        goalFrame.position = GameScreen.instance.topLeft + CGPoint(x: 10 + goalFrame.center.x, y: -40)
        self.addChild(goalFrame)
        let pairList = PairList(nrPairs: nrPairs)
        pairList.name = "pairList"
        pairList.zPosition = Layer.Overlay1
        pairList.position = GameScreen.instance.topLeft + CGPoint(x: 130, y: -40)
        self.addChild(pairList)
        
        let hintx = Int(hintArr[0])!, hinty = Int(hintArr[1])!
        hint = SKSpriteNode(imageNamed: "spr_arrow_hint_\(hintArr[2])")
        hint.zPosition = Layer.Scene2
        hint.position = tileField.layout.toPosition(hintx, row: hinty)
        hint.hidden = true
        self.addChild(hint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if quitButton.tapped{
            GameStateManager.instance.switchTo("level")
        }
        
        if retryButton.tapped && !firstMoveMade{
            print("Retry tapped")
        }
        
        if hintButton.tapped && firstMoveMade{
            hint.runAction(hintVisibleAction)
        }
    }
    
    func findAnimalAtPosition(col: Int, row: Int) -> Animal? {
        for obj in animals.children {
            let animal = obj as! Animal
            let (currcol, currrow) = animal.currentBlock
            if currcol == col && currrow == row && animal.velocity == CGPoint.zero {
                return animal
            }
        }
        return nil
    }
    
    func applyFirstMoveMade() {
        self.hintButton.hidden = true
        self.retryButton.hidden = false
        firstMoveMade = true
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        if !firstMoveMade {
            self.hintButton.hidden = !DefaultsManager.instance.hints
            self.retryButton.hidden = DefaultsManager.instance.hints
        }
    }
}
