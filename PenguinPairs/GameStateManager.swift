//
//  GameStateManager.swift
//  PenguinPairs
//
//  Created by MacMini on 8/15/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class GameStateManager : SKNode{
    static var instance = GameStateManager()
    var states : [SKNode] = []
    var currentState : SKNode? = nil
    var plannedSwitch : String? = nil
    
    func get(name : String) -> SKNode?{
        for state in states{
            if state.name == name{
                return state
            }
        }
        
        return nil
    }
    
    func switchTo(named : String){
        plannedSwitch = named
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        if plannedSwitch == nil || !has(plannedSwitch!) {
            return
        }
        
        self.removeAllChildren()
        currentState = get(plannedSwitch!)
        self.addChild(currentState!)
    }
    
    func has(name:String) -> Bool{
        for state in states{
            if state.name == name{
                return true
            }
        }
        
        return false
    }
    
    func add(state : SKNode){
        states.append(state)
    }
    
}
