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
            var boundingBox =  self.calculateAccumulatedFrame()
            if parent != nil {
                boundingBox.origin = scene!.convert(boundingBox.origin, from: parent!)
            }
            
            return boundingBox
        }
    }
    
    var worldPosition : CGPoint{
        get{
            if parent != nil{
                return parent!.convert(position, to: scene!)
            }
            else{
                return position
            }
        }
    }
    
    func handleInput(_ inputHelper: InputHelper) {
        for obj in children {
            if let node = obj as? SKNode{
                node.handleInput(inputHelper)
            }
        }
    }
    
    func updateDelta(_ delta: TimeInterval) {
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
