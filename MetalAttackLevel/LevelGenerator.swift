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
    var contextLevels = [20,20,20,20,20]
    var contextLowerBound = [1,21,41,61,81]
    
    var enemyContext1Array:Array<Enemy> = Array<Enemy>()
    var enemyContext2Array:Array<Enemy> = Array<Enemy>()
    var enemyContext3Array:Array<Enemy> = Array<Enemy>()
    var enemyContext4Array:Array<Enemy> = Array<Enemy>()
    var enemyContext5Array:Array<Enemy> = Array<Enemy>()
    
    var enemyArray:Array<Array<Enemy>> = Array<Array<Enemy>>()
    
    
    func generateLevel(_ totalNumberOfLevels:Int) {
        
        loadEnemies()
        
        for levelNumber in 2...totalNumberOfLevels + 1 {
            //let enemies = log2(Double(levelNumber)) * 5
            //let enemies = log2(Double(levelNumber)) * 3
            //let enemies = log10(Double(levelNumber))
            //let enemies = pow(Double(levelNumber),2.0)
            
            let enemies = log2(Double(levelNumber)) * 1.5
            
            let enemiesWithFactor = Int(enemies) * 8
            
            
            
            //print("\(levelNumber) --> number of enemies per level \(enemiesWithFactor)")
            
            let wavesArray = self.calculateWaves(enemiesWithFactor)
            
            let level = Level()
            level.waves = wavesArray
            level.levelNumber = "\(levelNumber - 1)"
            level.totalEnemies = "\(enemiesWithFactor)"
            level.levelContext = "\(calculateLevelContext(levelNumber))"
            level.enemies = chooseEnemies(calculateLevelContext(levelNumber),levelNumber: levelNumber)
            
            
            
            gameLevels.append(level)
        
        
        }
        generateJSONFile()
    }
    
    func loadEnemies() {
        enemyContext1Array = [Enemy(name: "skate_guy",armor: 3, damage: 3, timeToReach: 3, enemyContext: 1, dropCoinLowerLevel: 1, dropCoinHighLevel: 1),
                              Enemy(name: "divorced_woman",armor: 4, damage: 4, timeToReach: 2, enemyContext: 1, dropCoinLowerLevel: 1, dropCoinHighLevel: 2),
                              Enemy(name: "Dog",armor: 5, damage: 5, timeToReach: 2, enemyContext: 1, dropCoinLowerLevel: 2, dropCoinHighLevel: 3),
                              Enemy(name: "Fat_Cat", armor: 7, damage: 7, timeToReach: 2, enemyContext: 1, dropCoinLowerLevel: 2, dropCoinHighLevel: 4),
                              Enemy(name: "The_Gardener", armor: 11, damage: 11, timeToReach: 2, enemyContext: 1, dropCoinLowerLevel: 3, dropCoinHighLevel: 5)]
        
        enemyContext2Array = [Enemy(name: "Cooker",armor: 3, damage: 3, timeToReach: 3, enemyContext: 2, dropCoinLowerLevel: 1, dropCoinHighLevel: 3),
                              Enemy(name: "Bully",armor: 4, damage: 4, timeToReach: 3, enemyContext: 2, dropCoinLowerLevel: 2, dropCoinHighLevel: 3),
                              Enemy(name: "Cheerleader", armor: 6, damage: 6, timeToReach: 4, enemyContext: 2, dropCoinLowerLevel: 3, dropCoinHighLevel: 4),
                              Enemy(name: "CrazyTeacher", armor: 10, damage: 10, timeToReach: 4, enemyContext: 2, dropCoinLowerLevel: 3, dropCoinHighLevel: 5),
                              Enemy(name: "Principal",armor: 16, damage: 16, timeToReach: 3, enemyContext: 2, dropCoinLowerLevel: 4, dropCoinHighLevel: 6)]
        
        enemyContext3Array = [Enemy(name: "Cowboy",armor: 3, damage: 3, timeToReach: 4, enemyContext: 3, dropCoinLowerLevel: 2, dropCoinHighLevel: 4),
                              Enemy(name: "Drunk",armor: 6, damage: 6, timeToReach: 6, enemyContext: 3, dropCoinLowerLevel: 3, dropCoinHighLevel: 4),
                              Enemy(name: "Furious",armor: 9, damage: 9, timeToReach: 3, enemyContext: 3, dropCoinLowerLevel: 2, dropCoinHighLevel: 5),
                              Enemy(name: "Waitress",armor: 15, damage: 15, timeToReach: 5, enemyContext: 3, dropCoinLowerLevel: 4, dropCoinHighLevel: 6),
                              Enemy(name: "Whore",armor: 24, damage: 24, timeToReach: 4, enemyContext: 3, dropCoinLowerLevel: 5, dropCoinHighLevel: 7)]
        
        enemyContext4Array = [Enemy(name: "Guard",armor: 4, damage: 4, timeToReach: 2, enemyContext: 4, dropCoinLowerLevel: 2, dropCoinHighLevel: 3),
                              Enemy(name: "Ghost",armor: 8, damage: 8, timeToReach: 4, enemyContext: 4, dropCoinLowerLevel: 3, dropCoinHighLevel: 6),
                              Enemy(name: "Gang",armor: 12, damage: 12, timeToReach: 4, enemyContext: 4, dropCoinLowerLevel: 5, dropCoinHighLevel: 7),
                              Enemy(name: "Prisoner",armor: 20, damage: 20, timeToReach: 3, enemyContext: 4,dropCoinLowerLevel: 6, dropCoinHighLevel: 8),
                              Enemy(name:"Director",armor: 32, damage: 32, timeToReach: 6, enemyContext: 4, dropCoinLowerLevel: 7, dropCoinHighLevel: 8)]
        
        enemyContext5Array = [Enemy(name: "Borracheiro",armor: 5, damage: 5, timeToReach: 4, enemyContext: 5, dropCoinLowerLevel: 4, dropCoinHighLevel: 7),
                              Enemy(name: "Conveniencia",armor: 10, damage: 10, timeToReach: 4, enemyContext: 5, dropCoinLowerLevel: 5, dropCoinHighLevel: 7),
                              Enemy(name: "Frentista",armor: 15, damage: 15, timeToReach: 5, enemyContext: 5, dropCoinLowerLevel: 6, dropCoinHighLevel: 8),
                              Enemy(name: "Mecanico",armor: 25, damage: 25, timeToReach: 3, enemyContext: 5, dropCoinLowerLevel: 7, dropCoinHighLevel: 9),
                              Enemy(name: "Motoqueiro",armor: 40, damage: 40, timeToReach: 4, enemyContext: 5, dropCoinLowerLevel: 8, dropCoinHighLevel: 9)]
        
        //sort arrays by enemy power
        enemyContext1Array = enemyContext1Array.sorted(by: {$0.enemyPower < $1.enemyPower})
        enemyContext2Array = enemyContext2Array.sorted(by: {$0.enemyPower < $1.enemyPower})
        enemyContext3Array = enemyContext3Array.sorted(by: {$0.enemyPower < $1.enemyPower})
        enemyContext4Array = enemyContext4Array.sorted(by: {$0.enemyPower < $1.enemyPower})
        enemyContext5Array = enemyContext5Array.sorted(by: {$0.enemyPower < $1.enemyPower})
        
        
        enemyArray = [enemyContext1Array,enemyContext2Array,enemyContext3Array,enemyContext4Array,enemyContext5Array]
        
    }
    
    func calculateContextCompleteness(_ levelNumber:Int) -> Float {
        
        
        
        return 0.0
    }
    
    func calculateLevelContext(_ levelNumber:Int) -> Int {
        
        switch levelNumber {
        case 1...20:
            //print("Garage Context")
            return 1
        case 21...40: // + 20
            //print("School Context")
            return 2
        case 41...60: // + 30
            //print("Bar Context")
            return 3
        case 61...80: // + 50
            //print("Prision Context")
            return 4
        case 81...101: // + 80
            //print("Gas Station Context")
            return 5
        default:
            //print("default")
            return -1
        }
    }
    
    func chooseEnemies(_ levelContextIndex:Int, levelNumber:Int) -> Array<String> {
        // low probability of a powerfull enemy to appear on the first level
        // high probability of a powerfull enemy appear on last level
        // 1..10
        // 114..194
        //print("Level Context index \(levelContextIndex)")
        let totalLevelsPerContext = contextLevels[levelContextIndex - 1]
        let levelCompleteness:Float = Float(levelNumber - contextLowerBound[levelContextIndex - 1]) / Float(totalLevelsPerContext)
        
        
        let randomFactor = Int(10 * levelCompleteness)
        let correctedFactor = min(randomFactor,5)
        //print("\(correctedFactor)")
        
        var selectedEnemiesArray = Array<String>()
        let enemyContextArray = enemyArray[levelContextIndex - 1]
        //print("levelNumber \(levelNumber) correctedFactor \(correctedFactor) levelCompleteness \(levelCompleteness)")
        for _ in 1...5 {
            var randomEnemyPosition = Int(arc4random_uniform(UInt32(correctedFactor))) + Int(1 * levelCompleteness)
            randomEnemyPosition = min(randomEnemyPosition,4)
            var selectedEnemy = enemyContextArray[randomEnemyPosition]
            
            let filteredEnemies = selectedEnemiesArray.filter({$0 == selectedEnemy.name})
            
            if filteredEnemies.count == 3 {
                selectedEnemy = enemyContextArray[min(randomEnemyPosition+1,4)]
            }
            
            
            
            
            selectedEnemiesArray.append(selectedEnemy.name)
        }
        
        return selectedEnemiesArray
    }
    
    func calculateWaves(_ totalEnemies:Int) -> Array<String> {
        
        var wavesArray = Array<String>()
        
        if totalEnemies > 8 {
            
            //let maxWaveNumber = totalEnemies / 8
            let maxWaveNumber = min(24,totalEnemies)
            var enemiesLeft = totalEnemies
            
            
            var waveMultiple = Int(arc4random_uniform(UInt32(maxWaveNumber/8)) + 1)
            
            while enemiesLeft > 0 {
                
                let enemiesInWave = min(waveMultiple * 8,maxWaveNumber)
                wavesArray.append("\(enemiesInWave)")
                enemiesLeft = enemiesLeft - enemiesInWave
                if enemiesLeft > 0 {
            
                    
                    //waveMultiple = Int(arc4random_uniform(UInt32(enemiesLeft/8)) + 1)
                    waveMultiple = Int(arc4random_uniform(UInt32(maxWaveNumber/8)) + 1)
                    //waveMultiple = min(maxWaveNumber,waveMultiple)
                    if waveMultiple == (maxWaveNumber/8) {
                        waveMultiple = Int(arc4random_uniform(UInt32(maxWaveNumber/8))) + 1
                    }
                    
                    
                    //print("waveMultiple -> \(waveMultiple)  number of enemies -> \(enemiesLeft)")
                }
            }
        }else{
            wavesArray.append("8")
        }
        
        return wavesArray
    }
    
    func calculateLevelDificultPower(gameLevel:Level) {
        
        switch gameLevel.levelContext {
            case "1":
                calculateAverageEnemyPowerPerLevelEnemies(level: gameLevel, levelPossibleEnemies: gameLevel.enemies, enemiesArray: enemyContext1Array)
            case "2":
                calculateAverageEnemyPowerPerLevelEnemies(level: gameLevel, levelPossibleEnemies: gameLevel.enemies, enemiesArray: enemyContext2Array)
            case "3":
                calculateAverageEnemyPowerPerLevelEnemies(level: gameLevel, levelPossibleEnemies: gameLevel.enemies, enemiesArray: enemyContext3Array)
            case "4":
                calculateAverageEnemyPowerPerLevelEnemies(level: gameLevel, levelPossibleEnemies: gameLevel.enemies, enemiesArray: enemyContext4Array)
            case "5":
                calculateAverageEnemyPowerPerLevelEnemies(level: gameLevel, levelPossibleEnemies: gameLevel.enemies, enemiesArray: enemyContext5Array)
        default:
            print("calculateLevelDificultPower failed")
        }
        
    }
    
    func calculateAverageEnemyPowerPerLevelEnemies(level:Level,levelPossibleEnemies:[String],enemiesArray:Array<Enemy>) {
        var totalEnemyPower:Float = 0.0
        for enemyName in levelPossibleEnemies {
            let selectedEnemy = enemiesArray.first(where: {$0.name == enemyName})
            totalEnemyPower = totalEnemyPower + selectedEnemy!.enemyPower
        }
    
        let levelPower = Float(level.totalEnemies)! * totalEnemyPower
    
        print("Level \(level.levelNumber) power \(levelPower) ")
        
    }
    
    func generateJSONFile() {
        
        
        var levelArrayDict:Array<AnyObject> = []
        
        for gameLevel in gameLevels {
            var levelDict = Dictionary<String,AnyObject>()
            levelDict["levelNumber"] = gameLevel.levelNumber as AnyObject?
            levelDict["levelContext"] = gameLevel.levelContext as AnyObject?
            levelDict["levelTotalEnemies"] = gameLevel.totalEnemies as AnyObject?
            levelDict["avaliableEnemies"] = "5" as AnyObject?
            levelDict["waves"] = gameLevel.waves as AnyObject?
            levelDict["enemies"] = gameLevel.enemies as AnyObject?
            levelArrayDict.append(levelDict as AnyObject)
            
            //print("Game Level -> \(gameLevel.levelNumber)")
            calculateLevelDificultPower(gameLevel: gameLevel)
            
            
        }
        
        do {
            let objData = try JSONSerialization.data(withJSONObject: levelArrayDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStr = String(data:objData, encoding: String.Encoding.utf8)
            print(jsonStr!)
            
        }catch {
            
        
        }
        
    }

}


