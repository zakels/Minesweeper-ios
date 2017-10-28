//
//  GameScene.swift
//  Minesweerper
//
//  Created by 김범수 on 2017. 9. 22..
//  Copyright © 2017년 Dan Luo. All rights reserved.
//

import Foundation
import SpriteKit
//import UIColor_Hex_Swift
//import DeviceKit
import AVFoundation
import AudioToolbox

protocol GameSceneDelegate {
    
    func gameDidEnd()
    
}


class GameScene: SKScene {
    
    var containerView: SKSpriteNode!
    var board: GameBoard!
    var boardTextures: [SKTexture]!
    var boardSprites: [[GameTileSprite]] = []
    
    var lastTouchedSprite: GameTileSprite!
    var longPressTimer: Timer!
    
    var gameTimer: Timer!
    var gameTime: TimeInterval = 0
    var gameEnded: Bool = false
    
    var scoreLabel: SKLabelNode!
    var falgLabel: SKLabelNode!
    var timeLabel: SKLabelNode!
    var pauseSprite: SKLabelNode!
    var resumeSprite: SKLabelNode!
    var flagPSprite: SKLabelNode!
    var timePSprite: SKLabelNode!
    var time: Int = 10
    var level: Int = 0
    
    var flagCount: Int = 10
    override func willMove(from view: SKView) {
        SKTexture.preload(self.boardTextures, withCompletionHandler: {
        })
    }
    
    override func didMove(to view: SKView) {
        self.boardSprites = []
        self.removeAllChildren()

       
        self.boardTextures = [SKTexture(imageNamed: "mine"), SKTexture(imageNamed: "flag"), SKTexture(imageNamed: "tiles_notp"), SKTexture(imageNamed: "tiles_p")]
       
        let rows: Int = 8
        let squareSize = (self.view!.frame.size.width - CGFloat(rows)) / CGFloat(rows)
        let columns = Int((self.view!.frame.size.height - CGFloat(rows+50)) / squareSize)
  
        self.board = GameBoard(gameLevels: level, tileSize: squareSize, numberMine:flagCount)
        self.backgroundColor = UIColor.black
        
        self.setup()

        
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTime), userInfo: nil, repeats: true)
        
       
    }
    
    
    func reloadSprites() {
        
        self.boardSprites = []
        self.removeAllChildren()
        
        self.board.resetBoard()
        self.setup()
        
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTime), userInfo: nil, repeats: true)
        self.gameTime = 0
    }
    
    func setup () {
        flagCount = 10
        scoreLabel = SKLabelNode(text: "Money: 0")
        scoreLabel.position = CGPoint(x:self.view!.frame.minX, y: self.view!.frame.maxY-CGFloat(30))
        scoreLabel.horizontalAlignmentMode = .left
        self.addChild(self.scoreLabel)
        
        timeLabel = SKLabelNode(text: "00:00:00")
        timeLabel.position = CGPoint(x:self.view!.frame.maxX, y: self.view!.frame.maxY-CGFloat(30))
        timeLabel.horizontalAlignmentMode = .right
        self.addChild(self.timeLabel)
        
        
        falgLabel = SKLabelNode(text: "Flag: \(flagCount)")
        falgLabel.position = CGPoint(x:self.view!.frame.minX, y: self.view!.frame.maxY-CGFloat(50))
        falgLabel.horizontalAlignmentMode = .left
        self.addChild(self.falgLabel)
        
        pauseSprite = SKLabelNode(text: "Pause")
        pauseSprite.position = CGPoint(x:self.view!.frame.midX, y: self.view!.frame.maxY-CGFloat(30))
        pauseSprite.horizontalAlignmentMode = .center
        self.addChild(self.pauseSprite)
        
        resumeSprite = SKLabelNode(text: "Resume")
        resumeSprite.position = CGPoint(x:self.view!.frame.midX, y: self.view!.frame.maxY-CGFloat(50))
        resumeSprite.horizontalAlignmentMode = .center
        self.addChild(self.resumeSprite)
        
        flagPSprite = SKLabelNode(text: "flag+1")
        flagPSprite.position = CGPoint(x:self.view!.frame.maxX, y: self.view!.frame.maxY-CGFloat(50))
        flagPSprite.horizontalAlignmentMode = .right
        self.addChild(self.flagPSprite)
        
        timePSprite = SKLabelNode(text: "Time*1.5")
        timePSprite.position = CGPoint(x:self.view!.frame.maxX, y: self.view!.frame.maxY-CGFloat(70))
        timePSprite.horizontalAlignmentMode = .right
        self.addChild(self.timePSprite)
        
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = 0

        for y in 0..<self.board.tiles.count {
            
            var boardSpriteRow: [GameTileSprite] = []
            
            
            for x in 0..<self.board.tiles[y].count {
                
                let sprite = GameTileSprite(
                    forTile: self.board.tiles[y][x],
                    backgroundColor: self.backgroundColor,
                    bombColor: UIColor.red,
                    bombTexture: self.boardTextures[0],
                    flagTexture: self.boardTextures[1],
                    tileTexture: self.boardTextures[2],
                    pushTexture: self.boardTextures[3],
                    tileSize: CGSize(width: ceil(self.board.tileSize), height: ceil(self.board.tileSize)),
                    tilePosition: CGPoint(x: xPosition + self.board.tileSize/2, y: yPosition + self.board.tileSize/2)
                )
                
                self.addChild(sprite)
                
                boardSpriteRow.append(sprite)
                
                xPosition += self.board.tileSize
            }
            
            xPosition = 0
            yPosition += self.board.tileSize
            
            self.boardSprites.append(boardSpriteRow)
        }
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch {
            
        }

        
        
    
    }
    func resetBoard() {
        
        self.board.resetBoard()
        self.gameEnded = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !self.gameEnded {
            let location = touches.first!.location(in: self)
            let tiles = self.nodes(at: location)
            
            for tile in tiles {
                
                if tile == self.pauseSprite{
                     self.view?.isPaused = true
                     self.lastTouchedSprite = nil
                    if self.gameTimer != nil {
                        self.gameTimer.invalidate()
                    }

                }
                if tile == self.resumeSprite{
                    if self.view?.isPaused == true {
                        self.view?.isPaused = false
                        self.lastTouchedSprite = nil
                        if self.gameTimer != nil {
                        self.gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTime), userInfo: nil, repeats: true)
                        }
                    }
                }
                if tile == self.timePSprite {
                    self.time = 2*self.time - lrint(self.gameTime)
                }
                
                if tile == self.flagPSprite {
                    self.flagCount += 1
                    self.falgLabel.text = "Flag: \(flagCount)"
                }
                
                if tile == self.timePSprite {
                    self.gameTime = self.gameTime/2
                }
                
                if tile.isKind(of: GameTileSprite.self) {
                    if(self.view?.isPaused == false){
                        let mineTile: GameTileSprite = tile as! GameTileSprite
                    
                        if !mineTile.tile.isRevealed {
                        //self.touchDownSound!.play()
                        
                            self.lastTouchedSprite = mineTile
                            self.longPressTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameScene.addFlagToTile), userInfo: nil, repeats: false)
                        
                            let scaleAction = SKAction.scale(to: 0.9, duration: 0.1)
                            mineTile.run(scaleAction)
                        break
                        } else if mineTile.tile.isRevealed && mineTile.tile.isFlagged {
                            self.removeFlagToTile();
                        }
                    }
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(self.lastTouchedSprite != nil){
            self.longPressTimer.invalidate()
        
        
            if !self.lastTouchedSprite.tile.isRevealed {
            
                if !self.lastTouchedSprite.tile.isMineLocation {
                
                //self.touchUpSound!.play()
                self.revealTileSprite(self.lastTouchedSprite)
                } else {
                
                //self.bombExplodeSound!.play()
                self.revealAllTilesWithBombs()
                }
            }
        
            let scaleAction = SKAction.scale(to: 1.0, duration: 0.15)
            self.lastTouchedSprite.run(scaleAction)
        }
        
    }
    
    func revealTileSprite(_ tileSprite: GameTileSprite!) {
        
        if !tileSprite.tile.isRevealed && !tileSprite.tile.isFlagged {
            tileSprite.tile.isRevealed = true
            
            let distanceFromStartingPoint = abs(tileSprite.tile.row-self.lastTouchedSprite.tile.row)+abs(tileSprite.tile.column-self.lastTouchedSprite.tile.column)
            
            if distanceFromStartingPoint > 0 {
                tileSprite.updateSpriteTile(TimeInterval(CGFloat(distanceFromStartingPoint)*0.05))
            } else {
                tileSprite.updateSpriteTile()
            }
            
            self.revealAdjacentTiles(tileSprite)
        }
        
    }
    
    func revealAdjacentTiles(_ tileSprite: GameTileSprite!) {
        
        if tileSprite.tile.numNeighboringMines == 0 {
            
            let neighboringTiles = self.board.getNeighboringTiles(tileSprite.tile, includingDiagonal: false)
            
            for tile in neighboringTiles {
                
                let adjacentTileSprite = self.boardSprites[tile.column][tile.row] as GameTileSprite
                self.revealTileSprite(adjacentTileSprite)
            }
        }
    }
    
    func revealAllTilesWithBombs() {
        
        for y in 0..<self.board.columns {
            
            for x in 0..<self.board.rows {
                
                let currentTileSprite = self.boardSprites[y][x] as GameTileSprite
                
                if currentTileSprite.tile.isMineLocation {
                    
                    currentTileSprite.tile.isRevealed = true
                    currentTileSprite.updateSpriteTile()
                    
                }
            }
        }
        
        if let delegate = (self.delegate as? GameViewController) {
            self.gameEnded = true
            self.gameTimer.invalidate()
            delegate.gameDidEnd()
        }
    }
    
    func addFlagToTile() {
        
        if !self.lastTouchedSprite.tile.isFlagged && !self.lastTouchedSprite.tile.isRevealed && self.flagCount > 0{
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
           
            self.lastTouchedSprite.tile.isFlagged = true
            self.lastTouchedSprite.tile.isRevealed = true
            
            self.lastTouchedSprite.updateSpriteTile()
            
            let boardResults = self.board.getCurrentBoardResults()
            self.flagCount -= 1
            self.falgLabel.text = "Flag: \(flagCount)"

            if boardResults[0] == boardResults[2] {
                if let delegate = (self.delegate as? GameViewController) {
                    self.gameEnded = true
                    self.gameTimer.invalidate()
                    delegate.gameDidEnd()
                }
            }
        }
    }
    
    func removeFlagToTile() {
        if self.lastTouchedSprite.tile.isFlagged {
            self.lastTouchedSprite.tile.isFlagged = false
            self.lastTouchedSprite.tile.isRevealed = false
            self.lastTouchedSprite.updateFlagTile()
            self.flagCount += 1
            self.falgLabel.text = "Flag: \(flagCount)"
        }
    }
    
    func resetScene(){
        
        for y in 0..<self.board.columns {
            
            for x in 0..<self.board.rows {
                
                let currentTileSprite = self.boardSprites[y][x] as GameTileSprite
                
                let distanceFromStartingPoint = abs(currentTileSprite.tile.row-(self.board.rows/2))+abs(currentTileSprite.tile.column-(self.board.columns/2))
                currentTileSprite.updateSpriteTile(TimeInterval(CGFloat(distanceFromStartingPoint)*0.020))
            }
        }
        
        Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(GameScene.reloadSprites), userInfo: nil, repeats: false)
    }
    
    func updateTime() {
        self.gameTime += 1
        let totalSeconds = self.time - lrint(self.gameTime)
        if totalSeconds < 0 {
            if let delegate = (self.delegate as? GameViewController) {
                self.gameEnded = true
                self.gameTimer.invalidate()
                delegate.gameDidEnd()
            }
        }

        let h = totalSeconds / 3600
        let m = (totalSeconds % 3600) / 60
        let s = (totalSeconds % 3600) % 60
        var temp = "";
        if(h < 10) {temp = "0"+"\(h):"}
        else {temp = "\(h);"}
        if(m < 10) {temp += "0"+"\(m):"}
        else {temp += "\(m):"}
        if(s < 10) {temp += "0"+"\(s):"}
        else {temp += "\(s)"}
        self.timeLabel.text = temp
        
           }
    
    // NSNotificationCenter callbacks
    
    func pauseTimer(_ notification: Notification!) {
        if self.gameTimer != nil {
            self.gameTimer.invalidate()
        }
    }
    
    func resumeTimer(_ notification: Notification!) {
        
        if self.gameTimer != nil {
            
            self.gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTime), userInfo: nil, repeats: true)
        }
    }
}
