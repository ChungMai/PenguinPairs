//
//  TileField.swift
//  PenguinPairs
//
//  Created by MacMini on 8/18/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class TileField : SKNode{
    
    var layout : GridLayout
    
    init(rows: Int, columns : Int, cellWidth : Int, cellHeight : Int){
        layout = GridLayout(rows: rows, columns: columns, cellWidth:  cellWidth, cellHeight: cellHeight)
        super.init()
        layout.target = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTileType(_ row:Int, column:Int) -> TileType{
        if let obj = layout.at(column, row: row) as? Tile{
            return obj.type
        }
        
        return TileType.background
    }
}
