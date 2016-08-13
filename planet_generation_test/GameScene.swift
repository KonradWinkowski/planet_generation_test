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
        
        planet_info = [[Int]](count:4, repeatedValue:[Int](count:4, repeatedValue:0))
        
        for index_y in 0..<planet_info!.count {
            for index_x in 0..<planet_info!.count {
                planet_info![index_y][index_x] = Int(arc4random_uniform(100))
                
                let node = SKSpriteNode.init(color: UIColor.redColor(), size: CGSizeMake(10, 10))
                node.name = "\(index_y)\(index_x)"
                node.position = CGPointMake(CGFloat(index_x) * 10, CGFloat(index_y) * 10)
                self.addChild(node)
                
            }
        }
        
        planet_info = [[15,4,5,6],
                       [14,3,0,7],
                       [13,2,1,8],
                       [12,11,10,9]]
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        
        let center_x = planet_info!.count / 2;
        let center_y = planet_info!.count % 2 == 0 ? center_x - 1 : center_x
        
        var irritator_x = center_x
        var irritator_y = center_y + 1
        
        var move_down = 1
        var move_left = 1
        var move_up = 2
        var move_right = 2
        
        print(planet_info![center_y][center_x])
        
        var loop = true
        
        while loop && irritator_x < planet_info!.count && irritator_y < planet_info!.count {
            
            // left //
            let end_left = irritator_x - move_left
            var index_left = irritator_x
            
            while index_left > end_left && irritator_x > 0 {
                print(planet_info![irritator_y][index_left])
                
                index_left -= 1
                irritator_x -= 1
            }
            
            // up //
            let end_up = irritator_y - move_up
            var index_up = irritator_y
            
            while index_up > end_up && index_up > 0 {
                print(planet_info![index_up][irritator_x])
                
                index_up -= 1
                irritator_y -= 1
            }
            
            if end_up < 0 {
                print(planet_info![irritator_y][irritator_x])
                loop = false
                continue
            }
            
            // right //
            let end_right = irritator_x + move_right
            var index_right = irritator_x
            
            while index_right < end_right && index_right < planet_info!.count - 1 {
                print(planet_info![irritator_y][index_right])
                
                index_right += 1
                irritator_x += 1
            }
            
            // down //
            move_down += 2
            let end_down = irritator_y + move_down
            var index_down = irritator_y
            
            while index_down < end_down && index_down < planet_info!.count - 1 {
                print(planet_info![index_down][irritator_x])
                
                index_down += 1
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
