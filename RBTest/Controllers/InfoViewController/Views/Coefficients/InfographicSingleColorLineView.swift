//
//  InfographicSingleColorLineView.swift
//  RBTest
//
//  Created by Tatty on 03.05.2022.
//
import UIKit
import SnapKit

protocol InfographicSingleColorLineView: UIView {
    func configureView()
}

final class InfographicSingleColorLineViewImpl: UIView, InfographicSingleColorLineView {
    
    private enum Constants {
        static let commonOffset = 7.0
        static let valueLabelWidth = 45.0
        static let nameLabelWidth = 70.0
        static let fontSize = 13.0
        static let lineWidth = 10.0
        static let startPointX = 0.0
        static let defaultColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    private let viewModel: InfographicSingleColorLineViewModel
    
    override func draw(_ rect: CGRect) {
        createShapeLayer()
    }
    
    init(viewModel: InfographicSingleColorLineViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        createValueLabel()
        createNameLabel()
    }
    
    private func createValueLabel() {
        let label = UILabel()
        label.text = viewModel.labelValue
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = .black
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.snp.makeConstraints {
            $0.width.equalTo(Constants.valueLabelWidth)
            $0.top.equalTo(Constants.commonOffset)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(-Constants.commonOffset)
        }
    }
    
    private func createNameLabel() {
        let label = UILabel()
        label.text = viewModel.labelName
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = .gray
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let offset = Constants.valueLabelWidth + Constants.commonOffset
        label.snp.makeConstraints {
            $0.width.equalTo(Constants.nameLabelWidth)
            $0.top.equalTo(Constants.commonOffset)
            $0.trailing.equalTo(-offset)
            $0.bottom.equalTo(-Constants.commonOffset)
        }
    }
    
    private func createShapeLayer() {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: Constants.startPointX, y: bounds.midY)
        let rightOffset = Constants.commonOffset * 2 + Constants.nameLabelWidth + Constants.valueLabelWidth
        let endPointX = bounds.width - rightOffset
        
        let endPoint = CGPoint(x: endPointX, y: bounds.midY)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = Constants.defaultColor
        layer.lineWidth = Constants.lineWidth
        self.layer.addSublayer(layer)
        
        let fillPath = UIBezierPath()
        let fillEndPointX = viewModel.fillPercent * endPointX / 100
        let fillEndPoint = CGPoint(x: fillEndPointX, y: bounds.midY)
        fillPath.move(to: startPoint)
        fillPath.addLine(to: fillEndPoint)
        let fillLayer = CAShapeLayer()
        fillLayer.path = fillPath.cgPath
        fillLayer.strokeColor = viewModel.color.cgColor
        fillLayer.lineWidth = Constants.lineWidth
        self.layer.addSublayer(fillLayer)
    }
}
