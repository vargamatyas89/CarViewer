//
//  Error.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

enum TransformerError: Error {
    case transformingFailed
}

enum DownloadError: Error {
    case loadImageFailed
}
