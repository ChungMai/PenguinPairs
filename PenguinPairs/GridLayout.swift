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
    
    func toPosition(col : Int, row : Int) -> CGPoint
    {
        let xPos = -width/2 + ((col * cellWidth) + (cellWidth/2))
        let yPos = -height/2 + ((row * cellHeight) + (cellHeight/2))
        return CGPoint(x:xPos, y:yPos)
    }
    
    func add(obj : SKNode){
        if let target = self.target{
            let r  = target.children.count / columns
            let c : Int = target.children.count % columns
            target.addChild(obj)
            obj.position = toPosition(c, row : r)
        }
    }
    
    func at(col:Int,row:Int) -> SKNode?
    {
        if col > columns || col < 0 || row > rows || row < 0{
            return nil
        }
        
        if let target = target{
            let index = (row * columns) + columns
            return target.children[index] as? SKNode
        }
        
        return nil
    }
    
    func toGridLocation(position: CGPoint) -> (Int, Int) {
        let colindex = Int(floor((position.x + CGFloat(columns * (cellWidth + xPadding)) / 2) / CGFloat(cellWidth + xPadding)))
        let rowindex = Int(floor((position.y + CGFloat(rows * (cellHeight + yPadding)) / 2) / CGFloat(cellHeight + yPadding)))
        return (colindex, rowindex)
    }
}
