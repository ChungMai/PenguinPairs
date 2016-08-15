//
//  SKNode_Extension.swift
//  PenguinPairs
//
//  Created by Home on 8/14/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

extension SKNode{
    var box: CGRect {
        get {
            return self.calculateAccumulatedFrame()
        }
    }
    
    func handleInput(inputHelper: InputHelper) {
        for obj in children {
            if let node = obj as? SKNode{
                node.handleInput(inputHelper)
            }
        }
    }
    
    func updateDelta(delta: NSTimeInterval) {
        for obj in children {
            if let node = obj as? SKNode {
                node.updateDelta(delta)
            }
        }
    }
    
    func reset() {
        for obj in children {
            if let node = obj as? SKNode {
                node.reset()
            }
        }
    }
}
