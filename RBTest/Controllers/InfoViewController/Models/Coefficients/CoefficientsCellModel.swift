//
//  CoefficientsCellModel.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import Foundation

protocol CellModel {
   func viewDidLayoutSubviews()
}

extension CellModel {
    func viewDidLayoutSubviews() {}
}

final class CoefficientsCellModel: CellModel {
        
    let bestCoefficientValue: String
    let infographicViewModels: [InfographicSingleColorLineViewModel]
    
    init(coefficientValue: String, viewModels: [InfographicSingleColorLineViewModel]) {
        self.bestCoefficientValue = coefficientValue
        self.infographicViewModels = viewModels
    }
}
