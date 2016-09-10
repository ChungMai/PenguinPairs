//
//  SKSpriteNode_Extension.swift
//  PenguinPairs
//
//  Created by Home on 9/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    var center: CGPoint {
        get {
            return CGPoint(x: size.width / 2, y: size.height / 2)
        }
    }
}
