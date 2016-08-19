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
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        
        if hidden || boxed || isSharp || velocity != CGPoint.zero{
            return
        }
        
        if !inputHelper.containsTap(self.box){
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
        self.position = velocity * CGFloat(delta)
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
            //let lvl =  GameStateManager.instance.currentState as?
        }
    }
    
    var currentBlock: (Int, Int){
        get{
            if let tileField = childNodeWithName("//tileField") as? TileField{
                var edgePos = position
                if velocity.x > 0{
                    edgePos.x += CGFloat(tileField.layout.width/2)
                }
                else if velocity.x < 0{
                    edgePos.x -= CGFloat(tileField.layout.width/2)
                }
                else if velocity.y > 0{
                    edgePos.y += CGFloat(tileField.layout.height/2)
                }
                else if velocity.y < 0{
                    edgePos.y -= CGFloat(tileField.layout.height/2)
                }
                
                return tileField.layout.toGridLocation(edgePos)
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
    
    var isSeal: Bool {
        get {
            return type == "s"
        }
    }
    
    var isMulticolor: Bool {
        get {
            return type == "m"
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
}
