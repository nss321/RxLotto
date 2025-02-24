//
//  DateManager.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import UIKit

final class DateManager {
    static let shared = DateManager()
    
    private init() { }
    
    private let yyyyMMddFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    var yesterday: String {
        if let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            return yyyyMMddFormat.string(from: date)
        } else {
            print("어제 날짜 로드 실패: 20250101 반환")
            return "20250101"
        }
    }
}

