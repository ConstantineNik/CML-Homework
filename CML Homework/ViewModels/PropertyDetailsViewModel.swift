//
//  PropertyDetailsViewModel.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 22.04.2021.
//

import Foundation
 
protocol PropertyDetailsViewModelProtocol {
    func parseHtmlToString(_ html: String?) -> NSAttributedString
}

class PropertyDetailsViewModel: NSObject, PropertyDetailsViewModelProtocol {
    
    func parseHtmlToString(_ html: String?) -> NSAttributedString {
        let htmlText = html?.data(using: .utf8)
        guard let attributedString = try? NSAttributedString(
                data: htmlText!,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil) else { fatalError("Cannot convert html 2 string") }
        return attributedString
    }
}
