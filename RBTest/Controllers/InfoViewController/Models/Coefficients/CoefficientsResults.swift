//
//  CoefficientsResults.swift
//  RBTest
//
//  Created by Tatty on 03.05.2022.
//
import UIKit

struct CoefficientsResults {
    
    let color: UIColor
    let fillPercent: Double
    let name: String
    let value: String
    
    init(color: UIColor, name: String, value: Double) {
        self.color = color
        self.name = name
        self.value = String(value)
        self.fillPercent = (value / 5) * 100
    }
}
