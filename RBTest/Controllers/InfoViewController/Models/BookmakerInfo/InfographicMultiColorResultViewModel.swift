//
//  InfographicMultiColorResultViewModel.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import Foundation

protocol InfographicMultiColorResultViewModel {
    
    var view: InfographicMultiColorResultView? { get set }
    var points: InfographicPointsRepresentation? { get set }
    
    func calculatePoints()
    func updateViewRepresentation()
    func calculateResultsFor(type: RatesResults.CategoryType) -> Double
    func resultStringLabelFor(type: RatesResults.CategoryType) -> String
    func setView(_ view: InfographicMultiColorResultView)
}

final class InfographicMultiColorResultViewModelImpl: InfographicMultiColorResultViewModel {
    
    private let results: RatesResults
    weak var view: InfographicMultiColorResultView?
    var points: InfographicPointsRepresentation?
    
    init(_ results: RatesResults) {
        self.results = results
    }
    
    func updateViewRepresentation() {
        calculatePoints()
        view?.updateViewRepresentation()
        view?.createLabels()
    }
    
    func setView(_ view: InfographicMultiColorResultView) {
        self.view = view
    }
    
    func calculateResultsFor(type: RatesResults.CategoryType) -> Double {
        results.calculateResultsFor(type: type)
    }
    
    func resultStringLabelFor(type: RatesResults.CategoryType) -> String {
        results.resultStringLabelFor(type: type)
    }
    
    func calculatePoints() {
        guard let view = view else { return }
        points = InfographicPointsRepresentation(parentViewSize: view.frame.size,
                                                 redSize: results.calculateResultsFor(type: .winners),
                                                 greenSize: results.calculateResultsFor(type: .losers),
                                                 graySize: results.calculateResultsFor(type: .drawn))
    }
}
