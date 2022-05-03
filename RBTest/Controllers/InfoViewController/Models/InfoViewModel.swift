//
//  InfoViewModel.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import Foundation
import UIKit

protocol InfoViewModel {
    
    var numberOfSections: Int { get }
    var numberOfElements: Int { get }
    
    func createCellModel(for index: Int) -> CellModel
    func viewDidLayoutSubviews()
}

final class InfoViewModelImpl: InfoViewModel {
    
    private enum Constants {
        static let numberOfSections = 2
        static let numberOfRows = 1
        static let ratesResults = [RatesResults(bookmakerName: "Leon", bookmakerImageName: "leon", winners: 11, losers: 4, drawn: 7),
                                   RatesResults(bookmakerName: "William Hill", bookmakerImageName: "williamHill", winners: 27, losers: 11, drawn: 2)]
        static let bestCoefficientValue = "4.19"
        static let coefficientsResults = [CoefficientsResults(color: .red, name: "Выигрыш", value: 1.94),
                                          CoefficientsResults(color: .green, name: "Проигрыш", value: 1.54),
                                          CoefficientsResults(color: .gray, name: "Возврат", value: 0.48),
                                          CoefficientsResults(color: .blue, name: "Все ставки", value: 1.26)]
    }
    
    var numberOfSections: Int {
        Constants.numberOfSections
    }
    
    var numberOfElements: Int {
        Constants.numberOfRows
    }
    
    private lazy var coefficientsCellModel: CoefficientsCellModel = {
        CoefficientsCellModel(coefficientValue: Constants.bestCoefficientValue,
                              viewModels: Constants.coefficientsResults.map { InfographicSingleColorLineViewModelImpl($0) })
    }()
    
    private lazy var ratesCellModel: RatesCellModel = {
        RatesCellModel(bookmakers: Constants.ratesResults.map { RatesCellModel.Bookmaker($0) })
    }()
    
    func createCellModel(for section: Int) -> CellModel {
        section == 0 ? coefficientsCellModel : ratesCellModel
    }
    
    func viewDidLayoutSubviews() {
        ratesCellModel.viewDidLayoutSubviews()
        coefficientsCellModel.viewDidLayoutSubviews()
    }
}
