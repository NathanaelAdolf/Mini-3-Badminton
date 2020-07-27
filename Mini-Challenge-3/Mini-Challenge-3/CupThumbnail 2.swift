//
//  CupThumbnail.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 17/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import Foundation
import UIKit

class CupThumbnail
{
    var cupTitle: String!
    var cupDesc: String!
    var cupCode: String!
    
    init(title: String, desc: String, code: String) {
        self.cupTitle = title
        self.cupDesc = desc
        self.cupCode = code
    }
}
