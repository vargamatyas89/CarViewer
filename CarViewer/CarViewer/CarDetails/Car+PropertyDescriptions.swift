//
//  Car+PropertyDescriptions.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 19..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

extension Car {
    
    public var colorDescription: String {
        get {
            return self.color.replacingOccurrences(of: "_", with: " ").capitalized
        }
    }
    
    public var innerCleanlinessDescription: String {
        get {
            return "Inner cleanliness: \(self.innerCleanliness.replacingOccurrences(of: "_", with: " ").capitalized)"
        }
    }
    
    public var transmissionDescription: String {
        get {
            switch transmission {
            case "A":
                return "Automatic"
            default:
                return "Manual"
            }
        }
    }

}
