//
//  InfographicPointsRepresentation.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import UIKit

struct InfographicPointsRepresentation {
    
    typealias PercentSize = Double
    
    private enum Constants {
        static let gapSize: CGFloat = 7.0
        static let topYOffset: CGFloat = 15.0
    }
    
    let redLineStart: CGPoint
    let redLineEnd: CGPoint
    
    var firstGapStart: CGPoint {
        return redLineEnd
    }    
    var firstGapEnd: CGPoint {
        let x = firstGapStart.x + Constants.gapSize
        let y = firstGapStart.y
        return CGPoint(x: x, y: y)
    }
    
    let greenLineStart: CGPoint
    let greenLineEnd: CGPoint
    
    var secondGapStart: CGPoint {
        return greenLineEnd
    }
    var secondGapEnd: CGPoint {
        let x = secondGapStart.x + Constants.gapSize
        let y = secondGapStart.y
        return CGPoint(x: x, y: y)
    }
    
    let grayLineStart: CGPoint
    let grayLineEnd: CGPoint
    
    func topYOffset() -> CGFloat {
        return Constants.topYOffset
    }
    
    init(parentViewSize: CGSize, redSize: PercentSize, greenSize: PercentSize, graySize: PercentSize) {
        
        let width = parentViewSize.width - Constants.gapSize * 2
        
        redLineStart = CGPoint(x: .zero, y: Constants.topYOffset)
        let redLineWidth = width / 100 * redSize
        redLineEnd = CGPoint(x: redLineWidth, y: Constants.topYOffset)
        
        let greenLineStartX = redLineWidth + Constants.gapSize
        greenLineStart = CGPoint(x: greenLineStartX, y: Constants.topYOffset)
        let greenLineWidth = width / 100 * greenSize
        let greenLineXEnd = greenLineStartX + greenLineWidth
        greenLineEnd = CGPoint(x: greenLineXEnd, y: Constants.topYOffset)
        
        let grayLineStartX = greenLineXEnd + Constants.gapSize
        grayLineStart = CGPoint(x: grayLineStartX, y: Constants.topYOffset)
        grayLineEnd = CGPoint(x: width + Constants.gapSize * 2, y: Constants.topYOffset)
    }
}
