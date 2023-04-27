//
//  Date.swift
//  News
//
//  Created by Игорь Ущин on 28.04.2023.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yy   HH:mm:ss"
        return dateformat.string(from: self)
    }
}
