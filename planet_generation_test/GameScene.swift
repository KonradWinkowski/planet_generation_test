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
    var planet_center_point : CGPoint?
    var player : SKSpriteNode?
    var cam : SKCameraNode!
    
    override func didMoveToView(view: SKView) {
        
        view.ignoresSiblingOrder = true
        
        planet_info = [[Int]](count:100, repeatedValue:[Int](count:100, repeatedValue:0))
        
        let center_val = CGFloat((planet_info?.count)! / 2)
        
        planet_center_point = CGPointMake(center_val,center_val)
        
        generatePlanet()
        
        for index_y in 0..<planet_info!.count {
            for index_x in 0..<planet_info!.count {
                let val = planet_info![index_y][index_x]
                
                if val == 1 {
                    let node = SKSpriteNode.init(color: UIColor.redColor(), size: CGSizeMake(40, 40))
                    node.name = "\(index_y)\(index_x)"
                    node.position = CGPointMake(CGFloat(index_x) * 40, CGFloat(index_y) * 40)
                    node.zPosition = 1;
                    self.addChild(node)
                }
                
            }
        }
        
        player = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(40, 40))
        player?.name = "player"
        self.addChild(player!)
        
        cam = SKCameraNode() //initialize and assign an instance of SKCameraNode to the cam variable.
        
        self.camera = cam //set the scene's camera to reference cam
        self.addChild(cam) //make the cam a childElement of the scene itself.
        
        //position the camera on the gamescene.
        cam.position = (player?.position)!
        
        //
        //        planet_info = [[15,4,5,6],
        //                       [14,3,0,7],
        //                       [13,2,1,8],
        //                       [12,11,10,9]]
        
    }
    
    func generatePlanet() {
        for index_y in 0..<planet_info!.count {
            for index_x in 0..<planet_info!.count {
                let index_point = CGPointMake(CGFloat(index_x), CGFloat(index_y))
                
                let distance = distanceBetweenPoints(planet_center_point!, toPoint: index_point)
                
                if distance < 35 {
                    planet_info![index_y][index_x] = 1
                }
                
                print(distance)
            }
        }
    }
    
    func distanceBetweenPoints(center : CGPoint, toPoint : CGPoint) -> CGFloat {
        let xDist = (toPoint.x - center.x);
        let yDist = (toPoint.y - center.y);
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        
        return fabs(distance)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            let deltaY = location.y - previousLocation.y
            let deltaX = location.x - previousLocation.x
            cam.position.y += deltaY
            cam.position.x += deltaX
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func spiralOut() {
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
}
