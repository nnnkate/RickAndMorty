//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import Foundation
import UIKit

enum CharacterStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case uncnown = "Uncnown"
    
    var statusColor: UIColor {
        switch self {
        case .alive:
            return UIColor.green
            
        case .dead:
            return UIColor.red
            
        default:
            return UIColor.lightGray
        }
    }
}
