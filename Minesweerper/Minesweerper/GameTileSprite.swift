//
//  GameTileSprite.swift
//  Minesweerper
//
//  Created by 김범수 on 2017. 9. 22..
//  Copyright © 2017년 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
//import DeviceKit

class GameTileSprite: SKSpriteNode {
    
    var tile: GameTile!
    var textSprite: SKSpriteNode!
    var flagSprite: SKSpriteNode!
    var bombSprite: SKSpriteNode!
    var tileSprite: SKSpriteNode!
    var pushSprite: SKSpriteNode!
  
    
    init(forTile tile: GameTile, backgroundColor: UIColor!, bombColor: UIColor!, bombTexture: SKTexture!, flagTexture: SKTexture!, tileTexture: SKTexture!, pushTexture: SKTexture!, tileSize size: CGSize!, tilePosition position: CGPoint) {
        
        super.init(texture: tileTexture, color: UIColor.clear, size: size)
        
        self.tile = tile
        
        
        
        self.size = size
        self.position = position
        
    
        
            
        if self.tile.numNeighboringMines > 0 && !self.tile.isMineLocation {
            self.textSprite = self.createTextSprite(pushTexture)
            self.addChild(textSprite)
        }
        
        self.tileSprite = self.createTileSpriteWithTexture(tileTexture)
        self.addChild(self.tileSprite)
        
        self.pushSprite = self.createPushSpriteWithTexture(pushTexture)
        self.addChild(self.pushSprite)
        
        self.bombSprite = self.createBombSpriteWithTexture(bombTexture, backgroundColor: backgroundColor, bombColor: bombColor)
        self.addChild(self.bombSprite)
        
        self.flagSprite = self.createFlagSpriteWithTexture(flagTexture, backgroundColor: backgroundColor, flagColor: bombColor)
        self.addChild(self.flagSprite)
        
              
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTextSprite(_ texture: SKTexture!) -> SKSpriteNode {
        
        var labelPosition: CGPoint! = self.tile.numNeighboringMines > 1 ? CGPoint(x: 0.5, y: -6.5) : CGPoint(x: 0, y: -6.5)
        
           labelPosition = CGPoint(x: 1, y: -7)
        
        let label = SKLabelNode(text: self.tile.numNeighboringMines.description)
        label.fontSize = 19.0
        label.fontName = "AvenirNext-Bold"
        label.isUserInteractionEnabled = false
        label.position = labelPosition
        label.zPosition = 1
        
        label.fontColor = UIColor.black
        
        label.alpha = 1.0
        let background = self.createPushSpriteWithTexture(texture)
        background.addChild(label)
        return background
    }
    
    func createTileSpriteWithTexture(_ texture: SKTexture!) -> SKSpriteNode {
        
        let tileSprite = SKSpriteNode(texture: texture, color: UIColor.clear, size: self.size)
        tileSprite.position = CGPoint(x: 0, y: 0)
        tileSprite.alpha = 1.0
        tileSprite.zPosition = 1.0
        return tileSprite
        
    }
    
    func createPushSpriteWithTexture(_ texture: SKTexture!) -> SKSpriteNode {
        
        let pushSprite = SKSpriteNode(texture: texture, color: UIColor.clear, size: self.size)
        pushSprite.position = CGPoint(x: 0, y: 0)
        pushSprite.alpha = 0.0
        pushSprite.zPosition = 1.0
        return pushSprite
        
    }

    func createBombSpriteWithTexture(_ texture: SKTexture!,backgroundColor: UIColor!, bombColor: UIColor!) -> SKSpriteNode {
        
        let bombSprite = SKSpriteNode(texture: texture, color: bombColor, size: self.size)
        bombSprite.position = CGPoint(x: 0, y: 0)
        bombSprite.alpha = 0.0
        bombSprite.zPosition = 1.0
        
        
        return bombSprite
    }
    
    func createFlagSpriteWithTexture(_ texture: SKTexture!,backgroundColor: UIColor!, flagColor: UIColor!) -> SKSpriteNode {
        
        let flagSprite = SKSpriteNode(texture: texture, color: flagColor, size: self.size)
        flagSprite.position = CGPoint(x: 0, y: 0)
        flagSprite.alpha = 0.0
        flagSprite.zPosition = 1.0
        
        
        return flagSprite;
    }
    
    
    func updateSpriteTile(_ duration:TimeInterval = 0.15) {
        
       
        if self.tile.isRevealed {
            if self.tile.isRevealed {
              
            let alphaAnimation = SKAction.fadeAlpha(to: 0, duration: 0.15)
            let delayAnimation = SKAction.wait(forDuration: duration)
            self.tileSprite.run(SKAction.sequence([delayAnimation,alphaAnimation]))

            if self.textSprite != nil && !self.tile.isFlagged {
                self.textSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
            } else if self.tile.isFlagged {
                
                if self.flagSprite != nil{
                   self.flagSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
            }
                
            } else if self.tile.isMineLocation {
                self.bombSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
            } else if !self.tile.isFlagged && self.textSprite == nil && !self.tile.isMineLocation{
                self.pushSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
            }
            
        }else {
            let delayAnimation = SKAction.wait(forDuration: duration)
                    
            if let flagSprite = self.flagSprite {
                flagSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
            }
            
            if let bombSprite = self.bombSprite {
                bombSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
            }
            
            if let textSprite = self.textSprite {
                textSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
            }
            
        }
    }
}
}
