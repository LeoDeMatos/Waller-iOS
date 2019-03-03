//
//  TextExtensions.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 7/16/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func convertHtmlSymbols() throws -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let string = try NSAttributedString(data: data, options: options, documentAttributes: nil)
        
        return string
    }
}
