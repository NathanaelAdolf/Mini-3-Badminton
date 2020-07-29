//
//  Match.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 18/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import Foundation
import UIKit

class Match
{
    var firstPlayerName: String!
    var secondPlayerName: String!
    var status: String!
    var firstGame1: String!
    var firstGame2: String!
    var firstGame3: String!
    var secondGame1: String!
    var secondGame2: String!
    var secondGame3: String!
    
    init(firstPlayer: String, secondPlayer: String, status: String, firstGame1: String, firstGame2: String, firstGame3: String, secondGame1: String, secondGame2: String, secondGame3: String) {
        self.firstPlayerName = firstPlayer
        self.secondPlayerName = secondPlayer
        self.status = status
        self.firstGame1 = firstGame1
        self.firstGame2 = firstGame2
        self.firstGame3 = firstGame3
        self.secondGame1 = secondGame1
        self.secondGame2 = secondGame2
        self.secondGame3 = secondGame3
    }
}
