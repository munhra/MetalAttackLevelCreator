//
//  ViewController.swift
//  MetalAttackLevel
//
//  Created by Rafael M. A. da Silva on 4/9/16.
//  Copyright © 2016 munhra. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func generateLevels(_ sender: AnyObject) {
        let levelGenerator = LevelGenerator()
        levelGenerator.generateLevel(100)
        
   
    }
    
}

