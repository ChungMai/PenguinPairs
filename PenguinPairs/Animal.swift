//
//  Animal.swift
//  PenguinPairs
//
//  Created by MacMini on 8/18/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Animal : SKSpriteNode{
    
    var velocity = CGPoint.zero
    var isSharp : Bool = false
    var boxed : Bool = false
    var type = "x"
    var initialEmptyBox : Bool = false
    var initialPosition = CGPoint.zero
    
    init(type: String) {
        boxed = type.uppercaseString == type
        var spriteName = "spr_animal_\(type)"
        if boxed && type != "@" {
            spriteName = "spr_animal_boxed_\(type.lowercaseString)"
        }
        let texture = SKTexture(imageNamed: spriteName)
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
        self.type = type
        initialEmptyBox = type.lowercaseString == "@"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reset() {
        position = initialPosition
        velocity = CGPoint.zero
        hidden = false
        if initialEmptyBox {
            changeSpriteTo("@")
        }
    }
    
    func changeSpriteTo(type: String) {
        boxed = type.uppercaseString == type
        var spriteName = "spr_animal_\(type)"
        if boxed && type != "@" {
            spriteName = "spr_animal_boxed_\(type.lowercaseString)"
        }
        texture = SKTexture(imageNamed: spriteName)
        self.type = type
    }
    
    var isSeal: Bool {
        get {
            return type == "s" && !boxed
        }
    }
    
    var isMulticolor: Bool {
        get {
            return type == "m" && !boxed
        }
    }
    
    var isEmptyBox: Bool {
        get {
            return type == "@" && boxed
        }
    }
    
    var isShark: Bool {
        get {
            return type == "x"
        }
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        
        if hidden || boxed || isShark || velocity != CGPoint.zero {
            return
        }
        if !inputHelper.containsTap(box) {
            return
        }
        
        if let animalSelector = childNodeWithName("//animalSelector") as? AnimalSelector{
            if inputHelper.containsTap(animalSelector.box) || animalSelector.hidden{
                animalSelector.position = self.position
                animalSelector.hidden = false
                animalSelector.selectedAnimal = self
            }
        }
    }

    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        self.position += velocity * CGFloat(delta)
        if self.hidden || velocity == CGPoint.zero{
            return
        }
        
        let tileField = childNodeWithName("//tileField") as! TileField
        let (targetcol, targetrow) = currentBlock
        if(tileField.getTileType(targetrow, column: targetcol) == TileType.Background){
            self.hidden = true
            self.velocity = CGPoint.zero
        }
        else if tileField.getTileType(targetrow, column:targetcol) == .Wall {
            self.stopMoving()
        }
        else{
            let lvl = GameStateManager.instance.currentState as? LevelState
            if let a = lvl?.findAnimalAtPosition(targetcol, row: targetrow) {
                if a.hidden {
                    return
                }
                if a.isSeal {
                    stopMoving()
                } else if a.isEmptyBox {
                    self.hidden = true
                    a.changeSpriteTo(self.type.uppercaseString)
                } else if type.lowercaseString == a.type.lowercaseString || self.isMulticolor || a.isMulticolor {
                    a.hidden = true
                    self.hidden = true
                    let pairList = childNodeWithName("//pairList") as! PairList
                    pairList.addPair(type)
                } else if a.isShark {
                    a.hidden = true
                    self.hidden = true
                    stopMoving()
                } else {
                    self.stopMoving()
                }
            }
        }
    }

    var currentBlock: (Int, Int) {
        get {
            if let tileField = childNodeWithName("//tileField") as? TileField {
                var edgepos = position
                if velocity.x > 0 {
                    edgepos.x += CGFloat(tileField.layout.cellWidth) / 2
                } else if velocity.x < 0 {
                    edgepos.x -= CGFloat(tileField.layout.cellWidth) / 2
                } else if velocity.y > 0 {
                    edgepos.y += CGFloat(tileField.layout.cellHeight) / 2
                } else if velocity.y < 0 {
                    edgepos.y -= CGFloat(tileField.layout.cellHeight) / 2
                }
                return tileField.layout.toGridLocation(edgepos)
            }
            return (-1, -1)
        }
    }

    
    func stopMoving(){
        let tileField = childNodeWithName("//tileField") as! TileField
        velocity = CGPoint.normalize(velocity)
        let (currentCol, currentRow) = currentBlock
        position = tileField.layout.toPosition(currentCol - Int(velocity.x), row: currentRow - Int(velocity.y))
        velocity = CGPoint.zero
    }
}
