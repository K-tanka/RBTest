//
//  InfographicMultiColorResultView.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import UIKit

protocol InfographicMultiColorResultView: UIView {
    
    var viewModel: InfographicMultiColorResultViewModel { get }
    
    func updateViewRepresentation()
    func createLabels()
}

final class InfographicMultiColorResultViewImpl: UIView {
    
    private enum Constants {
        static let fontSize: CGFloat = 12
        static let lineWidth: CGFloat = 10
        static let defaultOffset: CGFloat = 50
        static let redColor: CGColor = UIColor.red.cgColor
        static let greenColor: CGColor = UIColor.green.cgColor
        static let grayColor: CGColor = UIColor.gray.cgColor
        static let gapColor: CGColor = UIColor.white.cgColor
    }
    
    let viewModel: InfographicMultiColorResultViewModel
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let points = viewModel.points else {
            return
        }

        createShapeLayer(from: points.redLineStart, to: points.redLineEnd, with: Constants.redColor)
        createShapeLayer(from: points.firstGapStart, to: points.firstGapEnd, with: Constants.gapColor)
        createShapeLayer(from: points.greenLineStart, to: points.greenLineEnd, with: Constants.greenColor)
        createShapeLayer(from: points.secondGapStart, to: points.secondGapEnd, with: Constants.gapColor)
        createShapeLayer(from: points.grayLineStart, to: points.grayLineEnd, with: Constants.grayColor)
    }
    
    init(viewModel: InfographicMultiColorResultViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    private func createShapeLayer(from startPoint: CGPoint, to endPoint: CGPoint, with color: CGColor) {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = color
        layer.lineWidth = Constants.lineWidth
        self.layer.addSublayer(layer)
    }
    
    func createLabels() {
        let commonYPosition = Constants.lineWidth + (viewModel.points?.topYOffset() ?? 0)
        
        let redResultLabel = UILabel()
        redResultLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        redResultLabel.text = viewModel.resultStringLabelFor(type: .winners)
        
        addSubview(redResultLabel)
        redResultLabel.translatesAutoresizingMaskIntoConstraints = false
        redResultLabel.snp.makeConstraints {
            $0.top.equalTo(commonYPosition)
            $0.leading.equalToSuperview()
        }
        
        let greenResultLabel = UILabel()
        greenResultLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        greenResultLabel.text = viewModel.resultStringLabelFor(type: .losers)
        
        let constant: CGFloat
        let greenLineStartX = viewModel.points?.greenLineStart.x ?? 0
        if greenLineStartX < Constants.defaultOffset {
            constant = Constants.defaultOffset
        } else {
            constant = greenLineStartX
        }
        
        greenResultLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(greenResultLabel)
        greenResultLabel.snp.makeConstraints {
            $0.top.equalTo(commonYPosition)
            $0.leading.lessThanOrEqualTo(constant)
            $0.trailing.equalTo(-Constants.defaultOffset)
        }
        
        let grayResultLabel = UILabel()
        grayResultLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        grayResultLabel.text = viewModel.resultStringLabelFor(type: .drawn)
        grayResultLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(grayResultLabel)
        grayResultLabel.snp.makeConstraints {
            $0.top.equalTo(commonYPosition)
            $0.trailing.equalToSuperview()
        }
    }
}

extension InfographicMultiColorResultViewImpl: InfographicMultiColorResultView {
    
    func updateViewRepresentation() {
        setNeedsDisplay()
    }
}
