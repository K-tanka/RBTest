//
//  CoefficientsCell.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import UIKit
import SnapKit

protocol ConfigurableCoefficients {
    
    func configure(_ cellModel: CoefficientsCellModel)
}

final class CoefficientsCell: UITableViewCell {
    
    private enum Constants {
        static let commonOffset = 10.0
        static let dividerHeight = 2.0
        static let bestCoefficientValueLabelHeight = 30.0
        static let bestCoefficientText = "Лучший коэффициент выигрыша"
        static let averageCoefficientsText = "Средние коэффициенты"
        static let bestCoefficientValueText = "K: "
        static let font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bestCoefficientView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bestCoefficientLabel: UILabel = {
        return createUILabel(text: Constants.bestCoefficientText)
    }()
    
    private lazy var bestCoefficientValueLabel: UILabel = {
        return createUILabel(textAlignment: .center, textColor: .white)
    }()
   
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var averageCoefficientsLabel: UILabel = {
        return createUILabel(text: Constants.averageCoefficientsText)
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CoefficientsCell: ConfigurableCoefficients {
    
    func configure(_ cellModel: CoefficientsCellModel) {
        bestCoefficientValueLabel.text = Constants.bestCoefficientValueText + cellModel.bestCoefficientValue
        configureCoefficientsInfo(cellModel: cellModel)
    }
}

private extension CoefficientsCell {
    
    func createUILabel(text: String = "", textAlignment: NSTextAlignment = .left, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = textAlignment
        label.font = Constants.font
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupUIElements() {
        configureBestCoefficientLabel()
        configureBestCoefficientView()
        configureDividerView()
        configureAverageCoefficientsLabel()
        configureStackView()
    }
    
    func configureBestCoefficientValueLabel() {
        bestCoefficientView.addSubview(bestCoefficientValueLabel)
        bestCoefficientValueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(Constants.commonOffset)
            $0.trailing.equalTo(-Constants.commonOffset)
        }
    }
    
    func configureBestCoefficientView() {
        configureBestCoefficientValueLabel()
        addSubview(bestCoefficientView)
        bestCoefficientView.snp.makeConstraints {
            $0.height.equalTo(Constants.bestCoefficientValueLabelHeight)
            $0.leading.equalTo(bestCoefficientLabel.snp.trailing).offset(Constants.commonOffset)
            $0.centerY.equalTo(bestCoefficientLabel.snp.centerY)
            $0.trailing.equalTo(-Constants.commonOffset)
        }
    }
    
    func configureBestCoefficientLabel() {
        addSubview(bestCoefficientLabel)
        bestCoefficientLabel.snp.makeConstraints {
            $0.top.leading.equalTo(Constants.commonOffset)
        }
    }
    
    func configureDividerView() {
        addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.height.equalTo(Constants.dividerHeight)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(bestCoefficientView.snp.bottom).offset(Constants.commonOffset)
        }
    }
    
    func configureAverageCoefficientsLabel() {
        addSubview(averageCoefficientsLabel)
        averageCoefficientsLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(Constants.commonOffset)
            $0.leading.equalTo(Constants.commonOffset)
            $0.trailing.equalTo(-Constants.commonOffset)
        }
    }
    
    func configureStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(averageCoefficientsLabel.snp.bottom).offset(Constants.commonOffset)
            $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: .zero, left: Constants.commonOffset, bottom: .zero, right: Constants.commonOffset))
        }
    }
    
    func configureCoefficientsInfo(cellModel: CoefficientsCellModel) {
        let infographicViews = cellModel.infographicViewModels.map { InfographicSingleColorLineViewImpl(viewModel: $0) }
        infographicViews.forEach { view in
            stackView.addArrangedSubview(view)
            view.configureView()
        }
    }
}
