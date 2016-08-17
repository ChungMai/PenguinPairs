//
//  Button.swift
//  PenguinPairs
//
//  Created by MacMini on 8/15/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class Button : SKSpriteNode{
    
    var tapped = false
    init(imageNamed : String){
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture:texture, color:UIColor.whiteColor(), size:texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var center : CGPoint{
        return CGPoint(x:self.size.width/2, y:self.size.height/2);
    }
    
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        tapped = inputHelper.containsTap(self.box)
    }
    
}
