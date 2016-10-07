//
//  Tile.swift
//  PenguinPairs
//
//  Created by MacMini on 8/18/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

enum TileType {
    case wall
    case background
    case normal
    case seal
    case empty
}

class Tile : SKSpriteNode{
    fileprivate var tp: TileType = .background
    
    convenience init(){
        self.init(imageNamed:"spr_wall", type: .background)
        self.isHidden = true
    }
    
    init(imageNamed: String, type: TileType){
        let texture = SKTexture(imageNamed:imageNamed)
        super.init(texture: texture, color: UIColor.white, size: texture.size())
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type : TileType{
        get{
            return tp
        }
        
        set {
            tp = newValue
            self.isHidden = tp == .background
        }
    }
}

