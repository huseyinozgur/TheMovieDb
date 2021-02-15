//
//  DateHelper.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 14.02.2021.
//

import UIKit
import Foundation

enum ServerDateFormat: String {
  case shortFormat = "yyyy-MM-dd"
}

enum ClientDateFormat: String {
  case shortFormat = "dd.MM.yyyy"
}

class DateHelper {
  
  static let shared = DateHelper()
  
  func dateFormatter(format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = ServerDateFormat.shortFormat.rawValue
    guard let date = formatter.date(from: format) else { return "" }
    return toString(date: date)
  }
  
  private func toString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = ClientDateFormat.shortFormat.rawValue
    return formatter.string(from: date)
  }
  
}
