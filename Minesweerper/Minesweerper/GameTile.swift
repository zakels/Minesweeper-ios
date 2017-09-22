//
//  GameTile.swift
//  Minesweerper
//
//  Created by 김범수 on 2017. 9. 22..
//  Copyright © 2017년 Dan Luo. All rights reserved.
//

import Foundation

class GameTile {
    
    let row:Int
    let column:Int
    
    // give these default values that we will re-assign later with each new game
    var numNeighboringMines = 0
    var isMineLocation = false
    var isRevealed = false
    var isFlagged = false
    
    init(row:Int, col:Int) {
        //store the row and column of the square in the grid
        self.row = row
        self.column = col
    }
}
