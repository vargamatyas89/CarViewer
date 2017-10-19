//
//  String+Extensions.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 19..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

extension String {
    mutating func appendLine(_ aString: String) {
        self.append("\n")
        self.append(aString)
    }
}
