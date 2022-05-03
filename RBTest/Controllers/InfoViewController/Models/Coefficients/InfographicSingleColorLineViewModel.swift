//
//  InfographicSingleColorLineViewModel.swift
//  RBTest
//
//  Created by Tatty on 03.05.2022.
//
import UIKit

protocol InfographicSingleColorLineViewModel {
    
    var color: UIColor { get }
    var fillPercent: Double { get }
    var labelName: String { get }
    var labelValue: String { get }
}

struct InfographicSingleColorLineViewModelImpl: InfographicSingleColorLineViewModel {
    
    let color: UIColor
    let fillPercent: Double
    let labelName: String
    let labelValue: String
    
    init(_ model: CoefficientsResults) {
        self.color = model.color
        self.fillPercent = model.fillPercent
        self.labelName = model.name
        self.labelValue = model.value
    }
}
