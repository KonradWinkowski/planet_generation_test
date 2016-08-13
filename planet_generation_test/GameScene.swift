//
//  GameScene.swift
//  planet_generation_test
//
//  Created by Konrad Winkowski on 8/13/16.
//  Copyright (c) 2016 KonradWinkowski. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var planet_info : [[Int]]?
    
    override func didMoveToView(view: SKView) {
        
        planet_info = [[Int]](count:10, repeatedValue:[Int](count:10, repeatedValue:0))
        
        for index_y in 0..<planet_info!.count {
            for index_x in 0..<planet_info!.count {
                planet_info![index_y][index_x] = Int(arc4random_uniform(100))
                
                let node = SKSpriteNode.init(color: UIColor.redColor(), size: CGSizeMake(10, 10))
                node.name = "\(index_y)\(index_x)"
                node.position = CGPointMake(CGFloat(index_x) * 10, CGFloat(index_y) * 10)
                self.addChild(node)
                
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        
        let center_x = planet_info!.count / 2;
        let center_y = center_x
        
        var irritator_x = center_x
        var irritator_y = center_y + 1
        
        var move_down = 1
        var move_left = 1
        var move_up = 2
        var move_right = 2
        
        print(planet_info![center_x][center_y])
        
        while irritator_x < planet_info!.count && irritator_y < planet_info!.count {
            
            // left //
            let end_left = irritator_x - move_left
            
            for var index_left = irritator_x; index_left > end_left; index_left -= 1 {
                print(planet_info![irritator_y][index_left])
                
                irritator_x -= 1
            }
            
            // up //
            let end_up = irritator_y - move_up
            
            for var index_up = irritator_y; index_up > end_up; index_up -= 1 {
                print(planet_info![index_up][irritator_x])
                irritator_y -= 1
            }
            
            // right //
            let end_right = irritator_x + move_right
            
            for var index_right = irritator_x; index_right < end_right; index_right += 1 {
                print(planet_info![irritator_y][index_right])
                irritator_x += 1
            }
            
            // down //
            move_down += 2
            let end_down = irritator_y + move_down
            
            for var index_down = irritator_y; index_down < end_down; index_down += 1 {
                print(planet_info![index_down][irritator_x])
                irritator_y += 1
            }
            
            let node = self.childNodeWithName("\(irritator_y)\(irritator_x)") as? SKSpriteNode
            node?.color = UIColor.blueColor()
            
            sleep(1)
            
            node?.color = UIColor.redColor()
            
            move_left += 2
            move_up += 2
            move_right += 2
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
