//
//  Math.swift
//  PenguinPairs
//
//  Created by MacMini on 8/17/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

func - (left:CGPoint,right:CGPoint) -> CGPoint{
    return CGPoint(x:(left.x - right.x),y:(left.y - right.y))
}

func == (left: CGPoint, right: CGPoint) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

func * (point: CGPoint, increase : CGFloat) -> CGPoint{
    return CGPoint(x: point.x * increase, y: point.y * increase)
}