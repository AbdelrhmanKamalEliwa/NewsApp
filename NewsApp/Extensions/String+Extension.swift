//
//  String+Extension.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 07/06/2021.
//

import UIKit

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func size(of font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func convertToDate(formatter: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en")
        dateFormatter.dateFormat = formatter
        let creationDate = dateFormatter.date(from: self) ?? Date()
        return creationDate
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
