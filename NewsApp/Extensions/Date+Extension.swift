//
//  Date+Extension.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 29/07/2021.
//

import Foundation

extension Date {
    func convertToString(stringFormatt: String = "yyyy/MM/dd hh:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringFormatt
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
