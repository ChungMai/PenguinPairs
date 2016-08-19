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
    
    init(fileReader: FileReader, levelNr : Int){
        super.init()
        self.levelNr = levelNr
        self.name = "level\(levelNr)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
