//
//  Extension + Double.swift
//  video length calculator
//
//  Created by Sasan Soroush on 4/4/20.
//  Copyright © 2020 Sasan Soroush. All rights reserved.
//

import Foundation

extension Double {
  func asString() -> String {
    let seconds = Int(self) + 1
    let hours = seconds/3600
    let minutes = (seconds % 3600) / 60
    if hours == 0 {
        return "\(minutes)m"
    } else {
        return "\(hours)h \(minutes)m"
    }
  }
}
