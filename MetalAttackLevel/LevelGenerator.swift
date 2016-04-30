//
//  LevelGenerator.swift
//  MetalAttackLevel
//
//  Created by Rafael M. A. da Silva on 4/9/16.
//  Copyright © 2016 munhra. All rights reserved.
//

import Foundation


class LevelGenerator {
    
    /* the number of enemies per level needs to be a multiple of 8 maybe change this*/
    
    var gameLevels = Array<Level>()
    var enemies = Array<Enemy>()
    var contextLevels = [10,31,62,113,194]
    
    var enemyContext1Array:Array<Enemy> = Array<Enemy>()
    var enemyContext2Array:Array<Enemy> = Array<Enemy>()
    var enemyContext3Array:Array<Enemy> = Array<Enemy>()
    var enemyContext4Array:Array<Enemy> = Array<Enemy>()
    var enemyContext5Array:Array<Enemy> = Array<Enemy>()
    
    var enemyArray:Array<Array<Enemy>> = Array<Array<Enemy>>()
    
    
    func generateLevel(totalNumberOfLevels:Int) {
        
        loadEnemies()
        
        for levelNumber in 2...totalNumberOfLevels {
            //let enemies = log2(Double(levelNumber)) * 5
            let enemies = log2(Double(levelNumber)) * 3
            //let enemies = log10(Double(levelNumber))
            //let enemies = pow(Double(levelNumber),2.0)
            
            let enemiesWithFactor = Int(enemies) * 8
            //print("\(levelNumber) --> number of enemies per level \(enemiesWithFactor)")
            
            let wavesArray = self.calculateWaves(enemiesWithFactor)
            
            let level = Level()
            level.waves = wavesArray
            level.levelNumber = "\(levelNumber)"
            level.totalEnemies = "\(enemiesWithFactor)"
            level.levelContext = "\(calculateLevelContext(levelNumber))"
            level.enemies = chooseEnemies(calculateLevelContext(levelNumber),levelNumber: levelNumber)
            
            
            
            gameLevels.append(level)
        
        
        }
        generateJSONFile()
    }
    
    func loadEnemies() {
        enemyContext1Array = [Enemy(name: "skate_guy",armor: 1, damage: 1, timeToReach: 3, enemyContext: 1),
                              Enemy(name: "divorced_woman",armor: 2, damage: 2, timeToReach: 4, enemyContext: 1),
                              Enemy(name: "Dog",armor: 3, damage: 3, timeToReach: 5, enemyContext: 1),
                              Enemy(name: "Fat_Cat", armor: 5, damage: 5, timeToReach: 3, enemyContext: 1),
                              Enemy(name: "The_Gardener", armor: 8, damage: 8, timeToReach: 4, enemyContext: 1)]
        
        enemyContext2Array = [Enemy(name: "Cooker",armor: 2, damage: 2, timeToReach: 3, enemyContext: 2),
                              Enemy(name: "Bully",armor: 4, damage: 4, timeToReach: 6, enemyContext: 2),
                              Enemy(name: "Cheerleader", armor: 6, damage: 6, timeToReach: 4, enemyContext: 2),
                              Enemy(name: "CrazyTeacher", armor: 10, damage: 10, timeToReach: 4, enemyContext: 2),
                              Enemy(name: "Principal",armor: 16, damage: 16, timeToReach: 3, enemyContext: 2)]
        
        enemyContext3Array = [Enemy(name: "Cowboy",armor: 3, damage: 3, timeToReach: 4, enemyContext: 3),
                              Enemy(name: "Drunk",armor: 6, damage: 6, timeToReach: 6, enemyContext: 3),
                              Enemy(name: "Furious",armor: 9, damage: 9, timeToReach: 3, enemyContext: 3),
                              Enemy(name: "Waitress",armor: 15, damage: 15, timeToReach: 5, enemyContext: 3),
                              Enemy(name: "Whore",armor: 24, damage: 24, timeToReach: 4, enemyContext: 3)]
        
        enemyContext4Array = [Enemy(name: "Guard",armor: 4, damage: 4, timeToReach: 2, enemyContext: 4),
                              Enemy(name: "Ghost",armor: 8, damage: 8, timeToReach: 4, enemyContext: 4),
                              Enemy(name: "Gang",armor: 12, damage: 12, timeToReach: 4, enemyContext: 4),
                              Enemy(name: "Prisoner",armor: 20, damage: 20, timeToReach: 3, enemyContext: 4),
                              Enemy(name:"Director",armor: 32, damage: 32, timeToReach: 6, enemyContext: 4)]
        
        enemyContext5Array = [Enemy(name: "Borracheiro",armor: 5, damage: 5, timeToReach: 4, enemyContext: 5),
                              Enemy(name: "Conveniencia",armor: 10, damage: 10, timeToReach: 4, enemyContext: 5),
                              Enemy(name: "Frentista",armor: 15, damage: 15, timeToReach: 5, enemyContext: 5),
                              Enemy(name: "Mecanico",armor: 25, damage: 25, timeToReach: 3, enemyContext: 5),
                              Enemy(name: "Motoqueiro",armor: 40, damage: 40, timeToReach: 4, enemyContext: 5)]
        
        //sort arrays by enemy power
        enemyContext1Array = enemyContext1Array.sort({$0.enemyPower < $1.enemyPower})
        enemyContext2Array = enemyContext2Array.sort({$0.enemyPower < $1.enemyPower})
        enemyContext3Array = enemyContext3Array.sort({$0.enemyPower < $1.enemyPower})
        enemyContext4Array = enemyContext4Array.sort({$0.enemyPower < $1.enemyPower})
        enemyContext5Array = enemyContext5Array.sort({$0.enemyPower < $1.enemyPower})
        
        
        enemyArray = [enemyContext1Array,enemyContext2Array,enemyContext3Array,enemyContext4Array,enemyContext5Array]
        
    }
    
    func calculateContextCompleteness(levelNumber:Int) -> Float {
        
        
        
        return 0.0
    }
    
    func calculateLevelContext(levelNumber:Int) -> Int {
        
        switch levelNumber {
        case 1...10:
            //print("Garage Context")
            return 1
        case 11...31: // + 20
            //print("School Context")
            return 2
        case 32...62: // + 30
            //print("Bar Context")
            return 3
        case 63...113: // + 50
            //print("Prision Context")
            return 4
        case 114...194: // + 80
            //print("Gas Station Context")
            return 5
        default:
            //print("default")
            return -1
        }
    }
    
    func chooseEnemies(levelContextIndex:Int, levelNumber:Int) -> Array<String> {
        // low probability of a powerfull enemy to appear on the first level
        // high probability of a powerfull enemy appear on last level
        // 1..10
        // 114..194
        
        let totalLevelsPerContext = contextLevels[levelContextIndex - 1]
        let levelCompleteness:Float = Float(levelNumber) / Float(totalLevelsPerContext)
        
        let randomFactor = Int(5 * levelCompleteness)
        let correctedFactor = min(randomFactor,5)
        //print("\(correctedFactor)")
        
        var selectedEnemiesArray = Array<String>()
        let enemyContextArray = enemyArray[levelContextIndex - 1]
        
        for _ in 1...5 {
            var randomEnemyPosition = random() % correctedFactor + Int( 1 * levelCompleteness)
            randomEnemyPosition = min(randomEnemyPosition,4)
            let selectedEnemy = enemyContextArray[randomEnemyPosition]
            selectedEnemiesArray.append(selectedEnemy.name)
        }
        
        return selectedEnemiesArray
    }
    
    func calculateWaves(totalEnemies:Int) -> Array<String> {
        
        var wavesArray = Array<String>()
        
        if totalEnemies > 8 {
            
            let maxWaveNumber = totalEnemies / 8
            var enemiesLeft = totalEnemies
            var waveMultiple = 1 + random() % maxWaveNumber
            
            while enemiesLeft > 0 {
                
                let enemiesInWave = waveMultiple * 8
                wavesArray.append("\(enemiesInWave)")
                enemiesLeft = enemiesLeft - enemiesInWave
                if enemiesLeft > 0 {
                    waveMultiple = 1 + random() % enemiesLeft/8
                    //print("waveMultiple -> \(waveMultiple)  number of enemies -> \(enemiesLeft)")
                }
            }
        }else{
            wavesArray.append("8")
        }
        
        return wavesArray
    }
    
    func generateJSONFile() {
        
        
        var levelArrayDict:Array<AnyObject> = []
        
        for gameLevel in gameLevels {
            var levelDict = Dictionary<String,AnyObject>()
            levelDict["levelNumber"] = gameLevel.levelNumber
            levelDict["levelContext"] = gameLevel.levelContext
            levelDict["levelTotalEnemies"] = gameLevel.totalEnemies
            levelDict["avaliableEnemies"] = "5"
            levelDict["waves"] = gameLevel.waves
            levelDict["enemies"] = gameLevel.enemies
            levelArrayDict.append(levelDict)
        }
        
        do {
            let objData = try NSJSONSerialization.dataWithJSONObject(levelArrayDict, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonStr = String(data:objData, encoding: NSUTF8StringEncoding)
            print(jsonStr!)
            
        }catch {
            
        
        }
        
    }

}


