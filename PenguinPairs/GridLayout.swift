//
//  GridLayout.swift
//  PenguinPairs
//
//  Created by Home on 8/14/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class GridLayout{
    var cellWidth : Int = 0, cellHeight : Int = 0, rows : Int = 0, columns : Int = 0
    var xPadding : Int = 0, yPadding : Int = 0
    var target : SKNode? = nil
    
    init(rows : Int, columns : Int, cellWidth : Int, cellHeight : Int){
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.rows = rows
        self.columns = columns
    }
    
    var width : Int{
        get{
            return (columns * cellWidth + (columns-1) * xPadding)
        }
    }
    
    var height : Int{
        get{
            return (rows * cellHeight + (rows-1) * yPadding)
        }
    }
    
    func toPosition(_ col: Int, row: Int) -> CGPoint {
        let xpos = -CGFloat(width/2) + CGFloat(col * (cellWidth + xPadding) + cellWidth / 2)
        let ypos = -CGFloat(height/2) + CGFloat(row * (cellHeight + yPadding) + cellHeight / 2)
        return CGPoint(x: xpos, y: ypos)
    }
    
    func add(_ obj : SKNode){
        if let target = self.target{
            let r  = target.children.count / columns
            let c : Int = target.children.count % columns
            target.addChild(obj)
            obj.position = toPosition(c, row : r)
        }
    }
    
    func at(_ col: Int, row: Int) -> SKNode? {
        if col < 0 || col >= columns || row < 0 || row >= rows {
            return nil
        }
        if let target_unwrapped = target {
            let index = row * columns + col
            return target_unwrapped.children[index]
        }
        return nil
    }

    
    func toGridLocation(_ position: CGPoint) -> (Int, Int) {
        let colindex = Int(floor((position.x + CGFloat(columns * (cellWidth + xPadding)) / 2) / CGFloat(cellWidth + xPadding)))
        let rowindex = Int(floor((position.y + CGFloat(rows * (cellHeight + yPadding)) / 2) / CGFloat(cellHeight + yPadding)))
        return (colindex, rowindex)
    }
}
