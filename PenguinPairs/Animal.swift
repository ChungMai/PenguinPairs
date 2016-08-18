//
//  Animal.swift
//  PenguinPairs
//
//  Created by MacMini on 8/18/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Animal : SKNode{
    
    var velocity = CGPoint.zero
    var isSharp : Bool = false
    var boxed : Bool = false
    
    override init(){
        super.init()
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
    
}
