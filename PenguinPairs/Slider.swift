//
//  Slider.swift
//  PenguinPairs
//
//  Created by Home on 8/14/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Slider : SKNode{
    var back = SKSpriteNode(imageNamed:"spr_slider_bar")
    var front = SKSpriteNode(imageNamed:"spr_slider_button")
    var leftMargin = CGFloat(4), rightMargin = CGFloat(7)
    var dragging = false
    var draggingIndex : Int?
    
    override init() {
        super.init()
        self.addChild(back)
        self.addChild(front)
        front.position = CGPoint(x: leftMargin - back.size.width/2 + front.size.width/2, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var value : CGFloat{
        get{
            return (front.position.x-front.size.width/2 - (back.position.x - back.size.width/2) - leftMargin)/(back.size.width - front.size.width - leftMargin - rightMargin)
        }
        
        set{
            front.position.x = newValue * (back.size.width - front.size.width - leftMargin - rightMargin) + leftMargin - back.size.width/2 + front.size.width/2
        }
    }
    
    func clamp(_ number:CGFloat, min:CGFloat, max:CGFloat) -> CGFloat{
        if number < min{
            return min
        }
        else if number > max{
            return max
        }
        else{
            return number
        }
    }
    
    override func handleInput(_ inputHelper: InputHelper) {
        if !inputHelper.isTouching{
            dragging = false
            draggingIndex = nil
            return
        }
        
        if inputHelper.containsTouch(back.box) {
            draggingIndex = inputHelper.getIDInRect(back.box)
            dragging = true
        }
        
        if !dragging {
            return
        }
        
        if let draggingUnwrap = draggingIndex {
            let touchPos = inputHelper.getTouch(draggingUnwrap)
            front.position.x = clamp(touchPos.x - back.worldPosition.x,
                                     min: leftMargin - back.size.width/2 + front.size.width/2, max: back.size.width/2 - front.size.width/2 - rightMargin)
        }

    }
    
    
   
}

