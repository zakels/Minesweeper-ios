//
//  GameViewController.swift
//  Minesweerper
//
//  Created by 김범수 on 2017. 9. 22..
//  Copyright © 2017년 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AudioToolbox

class GameViewController: UIViewController, SKSceneDelegate, GameEndViewControllerDelegate {
    
    var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let skView = SKView(frame: self.view.bounds)
        self.view = skView
        
        if skView.scene == nil {
            
            self.gameScene = GameScene(size: skView.bounds.size)
            self.gameScene.scaleMode = .aspectFit
            self.gameScene.delegate = self
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            skView.presentScene(self.gameScene)
        }
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    // SMGameSceneDelegate
    
    func gameDidEnd() {
        
        let finalBoardResults = self.gameScene.board.getCurrentBoardResults()
        
        let gameStats = [
            "timeTaken"          : self.gameScene.gameTime,
            "mineCount"          : finalBoardResults[0],
            "flagCount"          : finalBoardResults[1],
            "flaggedMineCount"   : finalBoardResults[2],
            "revealedTileCount"  : finalBoardResults[3],
            "scores"             : finalBoardResults[4],
            "totalTiles"         : self.gameScene.board.columns * self.gameScene.board.rows
            ] as [String : Any]
        
        self.gameScene.resetBoard()
        
        let gameEndedViewController = GameEndViewController(stats: gameStats as NSDictionary)
        gameEndedViewController.delegate = self
        gameEndedViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        self.present(gameEndedViewController, animated: true, completion: nil)
    }
    
    // SMGameEndViewControllerDelegate
    
    func resetScene() {
        self.gameScene.resetScene()
    }
}
