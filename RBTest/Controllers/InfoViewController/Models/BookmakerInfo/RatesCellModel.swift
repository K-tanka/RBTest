//
//  RatesCellModel.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import Foundation
import UIKit

final class RatesCellModel: CellModel {
    
    struct Bookmaker {
        let name: String
        let image: UIImage?
        let amountRates: String
        let infographicViewModel: InfographicMultiColorResultViewModel
        
        init(_ model: RatesResults) {
            self.name = model.bookmakerName
            self.image = UIImage(named: model.bookmakerImageName)
            self.amountRates = String(model.amounRates)
            self.infographicViewModel = InfographicMultiColorResultViewModelImpl(model)
        }
    }
      
    let bookmakers: [Bookmaker]
    
    init(bookmakers: [Bookmaker]) {
        self.bookmakers = bookmakers
    }
 
    func viewDidLayoutSubviews() {
        bookmakers.forEach { $0.infographicViewModel.updateViewRepresentation() }
    }
}

extension RatesCellModel.Bookmaker: Equatable {
    static func == (lhs: RatesCellModel.Bookmaker, rhs: RatesCellModel.Bookmaker) -> Bool {
        lhs.name == rhs.name
    }
}
