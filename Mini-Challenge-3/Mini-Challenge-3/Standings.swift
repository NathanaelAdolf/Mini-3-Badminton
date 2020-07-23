//
//  Standings.swift
//  Mini-Challenge-3
//
//  Created by Stefan Jivalino on 23/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import Foundation
import UIKit

class Standings
{
    var playerName: String!
    var play: String!
    var win: String!
    var lose: String!
    var dif: String!
    var point: String!
    
    init(playerName: String, play: String, win: String, lose: String, dif: String, point: String) {
        self.playerName = playerName
        self.play = play
        self.win = win
        self.lose = lose
        self.dif = dif
        self.point = point
    }
}
