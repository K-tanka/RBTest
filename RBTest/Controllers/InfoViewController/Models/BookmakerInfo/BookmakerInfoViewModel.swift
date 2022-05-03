//
//  BookmakerInfoViewModel.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import Foundation
import UIKit

protocol BookmakerInfoViewModel {
    
    var infographicViewModel: InfographicMultiColorResultViewModel { get }
    var isHiddenDivider: Bool { get }
    var amountRates: String { get }
    var image: UIImage? { get }
    
    func viewDidLayoutSubviews()
}

final class BookmakerInfoViewModelImpl: BookmakerInfoViewModel {
    
    var infographicViewModel: InfographicMultiColorResultViewModel
    var isHiddenDivider: Bool
    var amountRates: String
    var image: UIImage?
    
    init(infographicViewModel: InfographicMultiColorResultViewModel, isHiddenDivider: Bool, amountRates: String, image: UIImage?) {
        self.infographicViewModel = infographicViewModel
        self.isHiddenDivider = isHiddenDivider
        self.amountRates = amountRates
        self.image = image
    }
    
    func viewDidLayoutSubviews() {
        infographicViewModel.calculatePoints()
        infographicViewModel.updateViewRepresentation()
    }
}
