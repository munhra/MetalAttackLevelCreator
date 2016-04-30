//
//  Enemies.swift
//  MetalAttackLevel
//
//  Created by Rafael M. A. da Silva on 4/9/16.
//  Copyright © 2016 munhra. All rights reserved.
//

import Foundation

class Enemy {
    
    var name:String = ""
    var armor:Int = 0
    var damage:Int = 0
    var timeToReach:Int = 0
    var enemyPower:Float = 0.0
    var enemyContext:Int = 0
    
    init(name:String, armor:Int, damage:Int, timeToReach:Int, enemyContext:Int){
        self.name = name
        self.armor = armor
        self.damage = damage
        self.timeToReach = timeToReach
        self.enemyContext = enemyContext
    
        self.enemyPower = Float(armor) + Float(damage) + Float(1/timeToReach)
        
        
    }
}