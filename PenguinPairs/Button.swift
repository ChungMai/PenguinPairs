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
        super.init(texture:texture, color:UIColor.white, size:texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(_ inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        tapped = inputHelper.containsTap(self.box) && !self.isHidden
    }
    
}
