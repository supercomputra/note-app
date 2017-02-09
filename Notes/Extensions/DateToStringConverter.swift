//
//  DateToStringConverter.swift
//  Notes
//
//  Created by Zulwiyoza Putra on 10/29/16.
//  Copyright © 2016 Zulwiyoza Putra. All rights reserved.
//

import Foundation

extension Date {
    func dateToStringConverterDate() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    func dateToStringConverterHour() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }

}
