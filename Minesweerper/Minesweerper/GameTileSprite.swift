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
    var gradientLayer: CAGradientLayer!
    var gradientSprite: SKSpriteNode!
    var textSprite: SKLabelNode!
    var flagSprite: SKSpriteNode!
    var bombSprite: SKSpriteNode!
    var tileSprite: SKSpriteNode!
    
    init(forTile tile: GameTile, backgroundColor: UIColor!, bombColor: UIColor!, bombTexture: SKTexture!, flagTexture: SKTexture!, tileTexture: SKTexture!, pushTexture: SKTexture!, tileSize size: CGSize!, tilePosition position: CGPoint) {
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        self.tile = tile
        //self.tileSprite = SKSpriteNode(texture: tileTexture)
        //self.addChild(self.tileSprite)
        
        //self.gradientLayer = gradient
        
        self.size = size
        self.position = position
        
        /*self.gradientSprite = SKSpriteNode(texture: SKTexture(cgImage: self.createImageFromGradient(size, withLayer: self.gradientLayer, withMask: nil)), color: UIColor.clear, size: size)
        self.gradientSprite.isUserInteractionEnabled = false
        
        self.addChild(self.gradientSprite)
        */
        if self.tile.numNeighboringMines > 0 && !self.tile.isMineLocation {
            
            self.textSprite = self.createTextSprite()
            let background = SKSpriteNode(texture: pushTexture, size: self.size)
            background.position = CGPoint(x: CGFloat(-1), y: CGFloat(7))
            background.zPosition = -1
            textSprite.addChild(background)
            self.addChild(textSprite)
        }
        
        //self.tileSprite = self.createTileSpriteWithTexture(tileTexture, backgroundColor: backgroundColor, tileColor: bombColor)
        //self.addChild(self.tileSprite)
        
        self.bombSprite = self.createBombSpriteWithTexture(bombTexture, backgroundColor: backgroundColor, bombColor: bombColor)
        self.addChild(self.bombSprite)
        
        self.flagSprite = self.createFlagSpriteWithTexture(flagTexture, backgroundColor: backgroundColor, flagColor: bombColor)
        self.addChild(self.flagSprite)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTextSprite() -> SKLabelNode {
        
        //let isSmallDevice = Device().isOneOf([.iPhone4, .iPhone4s, .simulator(.iPhone4), .simulator(.iPhone4s)]) || Device().isPad
        
        //let isMediumDevice = Device().isOneOf([.iPodTouch5, .iPodTouch5, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .simulator(.iPodTouch5), .simulator(.iPodTouch5), .simulator(.iPhone5c), .simulator(.iPhone5s), .simulator(.iPhoneSE)])
        
        var labelPosition: CGPoint! = self.tile.numNeighboringMines > 1 ? CGPoint(x: 0.5, y: -6.5) : CGPoint(x: 0, y: -6.5)
        
        // Is iPhone 4 or 5
        /*if isSmallDevice {
            labelPosition = self.tile.numNeighboringMines > 1 ? CGPoint(x: 0.75, y: -7.5) : CGPoint(x: 0, y: -7)
        } else if isMediumDevice {
            labelPosition = CGPoint(x: 1, y: -7)
        }*/
        labelPosition = CGPoint(x: 1, y: -7)
        
        let label = SKLabelNode(text: self.tile.numNeighboringMines.description)
        label.fontSize = 19.0
        label.fontName = "AvenirNext-Bold"
        label.isUserInteractionEnabled = false
        label.position = labelPosition
        
        
        /*if let colors = self.gradientLayer.colors {
            label.fontColor = UIColor(cgColor: colors[0] as! CGColor)
        }*/
        
        label.alpha = 0.0
        
        return label
    }
    
    func createBombSpriteWithTexture(_ texture: SKTexture!, backgroundColor: UIColor!, bombColor: UIColor!) -> SKSpriteNode {
        
        let bombLayer = CALayer()
        bombLayer.frame.size = self.size
        bombLayer.backgroundColor = bombColor.cgColor
        
        let bombBackground = SKSpriteNode(texture: SKTexture(cgImage: self.createImageFromGradient(size, withLayer: bombLayer, withMask: nil)), color: bombColor, size: self.size)
        bombBackground.position = CGPoint(x: 0, y: 0)
        bombBackground.alpha = 0.0
        bombBackground.zPosition = 1.0
        
        let bombSprite = SKSpriteNode(texture: texture, color: bombColor, size: self.size)
        bombSprite.alpha = 1.0
        bombSprite.zPosition = 1.0
        
        bombBackground.addChild(bombSprite)
        
        return bombBackground
    }
    
    func createFlagSpriteWithTexture(_ texture: SKTexture!, backgroundColor: UIColor!, flagColor: UIColor!) -> SKSpriteNode {
        
        let flagLayer = CALayer()
        flagLayer.frame.size = self.size
        flagLayer.backgroundColor = flagColor.cgColor
        
        let flagBackground = SKSpriteNode(texture: SKTexture(cgImage: self.createImageFromGradient(self.size, withLayer: flagLayer, withMask: nil)), color: flagColor, size: self.size)
        flagBackground.position = CGPoint(x: 0, y: 0)
        flagBackground.alpha = 0.0
        flagBackground.zPosition = 1.0
        
        let flagSprite = SKSpriteNode(texture: texture, color: flagColor, size: self.size)
        flagSprite.alpha = 1.0
        flagSprite.zPosition = 1.0
        
        flagBackground.addChild(flagSprite)
        
        return flagBackground
    }
    
    /*func createTileSpriteWithTexture(_ texture: SKTexture!, backgroundColor: UIColor!, tileColor: UIColor!) -> SKSpriteNode {
        let tileLayer = CALayer()
        tileLayer.frame.size = self.size
        tileLayer.backgroundColor = tileColor.cgColor
        
        let tileBackground = SKSpriteNode(texture: SKTexture(cgImage: self.createImageFromGradient(self.size, withLayer: tileLayer, withMask: nil)), color: tileColor, size: self.size)
        tileBackground.position = CGPoint(x: 0, y: 0)
        tileBackground.alpha = 0.0
        tileBackground.zPosition = 1.0
        
        let tileSprite = SKSpriteNode(texture: texture, color: tileColor, size: self.size)
        tileSprite.alpha = 1.0
        tileSprite.zPosition = 1.0
        
        tileBackground.addChild(tileSprite)
        
        return tileBackground
    }*/
    
    func createImageFromGradient(_ size: CGSize!, withLayer layer:CALayer!, withMask mask:UIImage?) -> CGImage {
        
        let gradientLayer = layer
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        gradientLayer?.frame = CGRect(x: 0,y: 0, width: size.width, height: size.height).integral
        gradientLayer?.render(in: context!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if mask != nil {
            
            let maskRef = mask!.cgImage
            let maskCreated = CGImage(maskWidth: (maskRef?.width)!,
                                      height: (maskRef?.height)!,
                                      bitsPerComponent: (maskRef?.bitsPerComponent)!,
                                      bitsPerPixel: (maskRef?.bitsPerPixel)!,
                                      bytesPerRow: (maskRef?.bytesPerRow)!,
                                      provider: (maskRef?.dataProvider!)!, decode: nil, shouldInterpolate: false
            )
            
            let maskedImageRef = gradientImage?.cgImage?.masking(maskCreated!)
            let maskedImage = UIImage(cgImage: maskedImageRef!)
            
            // returns new image with mask applied
            return maskedImage.cgImage!
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let scaledSize = ceil(size.width*0.89)
        let rect = CGRect(x: 3, y: 2, width: scaledSize, height: scaledSize).integral
        context?.setShouldAntialias(true)
        let rectPath = UIBezierPath(roundedRect: rect, cornerRadius: size.width/2)
        rectPath.addClip()
        gradientImage?.draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!.cgImage!
        
    }
    
    func updateSpriteTile(_ duration:TimeInterval = 0.15) {
        
        var fadeAlphaTo: CGFloat = 1.0
        
        if self.tile.isRevealed {
            
            if !self.tile.isFlagged {
                
                if self.tile.numNeighboringMines == 1 {
                    fadeAlphaTo = 0.18
                } else if self.tile.numNeighboringMines == 2 {
                    fadeAlphaTo = 0.28
                } else if self.tile.numNeighboringMines >= 3 {
                    fadeAlphaTo = 0.4
                } else {
                    fadeAlphaTo = 0.05
                }
                
            }
            
            let alphaAnimation = SKAction.fadeAlpha(to: fadeAlphaTo, duration: 0.15)
            let delayAnimation = SKAction.wait(forDuration: duration)
            //self.gradientSprite.run(SKAction.sequence([delayAnimation, alphaAnimation]))
            
            if self.textSprite != nil && !self.tile.isFlagged {
                self.textSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
            } else if self.tile.isFlagged {
                
                if let flagSprite = self.flagSprite {
                    flagSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
                }
                
            } else if self.tile.isMineLocation {
                self.bombSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 1.0, duration: 0.15)]))
            }
            
        } else {
            
            let alphaAnimation = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
            let delayAnimation = SKAction.wait(forDuration: duration)
            //let textureAnimation = SKAction.animate(with: [SKTexture(cgImage: self.createImageFromGradient(self.gradientSprite.size, withLayer: self.gradientLayer, withMask: nil))], timePerFrame: 0.1)
            //self.gradientSprite.run(SKAction.sequence([delayAnimation, textureAnimation, alphaAnimation]))
            
            if let flagSprite = self.flagSprite {
                flagSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 0.0, duration: 0.1)]))
            }
            
            if let bombSprite = self.bombSprite {
                bombSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 0.0, duration: 0.1)]))
            }
            
            if let textSprite = self.textSprite {
                textSprite.run(SKAction.sequence([delayAnimation, SKAction.fadeAlpha(to: 0.0, duration: 0.1)]))
            }
            
        }
    }
}
