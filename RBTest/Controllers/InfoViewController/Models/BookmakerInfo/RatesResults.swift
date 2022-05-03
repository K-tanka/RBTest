//
//  RatesResults.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import Foundation
import UIKit

struct RatesResults {
    
    private enum Constants {
        static let precentSignPostfix = "%"
        static let formatType = "%.1f"
    }
    
    enum CategoryType {
        case winners
        case losers
        case drawn
    }
    
    let bookmakerName: String
    let bookmakerImageName: String
    let winners: Int
    let losers: Int
    let drawn: Int
    var amounRates: Int {
        winners + losers + drawn
    }
    
    func calculateResultsFor(type: CategoryType) -> Double {
        let total = Double(winners + losers + drawn)
        
        switch type {
        case .winners:
            return 100 * Double(winners) / total
        case .losers:
            return 100 * Double(losers) / total
        case .drawn:
            return 100 * Double(drawn) / total
        }
    }
    
    func resultStringLabelFor(type: CategoryType) -> String {
        switch type {
        case .winners:
            let percentString = String(format: Constants.formatType, calculateResultsFor(type: .winners)) + Constants.precentSignPostfix
            return "\(winners)(\(percentString))"
        case .losers:
            let percentString = String(format: Constants.formatType, calculateResultsFor(type: .losers)) + Constants.precentSignPostfix
            return "\(losers)(\(percentString))"
        case .drawn:
            let percentString =  String(format: Constants.formatType, calculateResultsFor(type: .drawn)) + Constants.precentSignPostfix
            return "\(drawn)(\(percentString))"
        }
    }
}
