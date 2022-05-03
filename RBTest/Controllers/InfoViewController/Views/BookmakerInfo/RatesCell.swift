//
//  RatesCell.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import UIKit
import SnapKit

protocol ConfigurableRates {
    func configure(_ cellModel: RatesCellModel)
}

final class RatesCell: UITableViewCell {
    
    private enum Constants {
        static let commonOffset = 10.0
        static let spacing = 10.0
        static let bookmakerInfoViewHeight = 100.0
        static let ratesText = "Выигрыши/проигрыши по букмекерам"
        static let amountRatesText = " ставок"
        static let font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    private lazy var ratesLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.ratesText
        label.font = Constants.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.spacing
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

extension RatesCell: ConfigurableRates {
    
    func configure(_ cellModel: RatesCellModel) {
        cellModel.bookmakers.forEach { bookmaker in
            configureBookmakerInfo(cellModel: cellModel, bookmaker: bookmaker)
        }
    }
}

private extension RatesCell {
    
    func setupUIElements() {
        configureRatesLabel()
        configureStackView()
    }
    
    func configureRatesLabel() {
        addSubview(ratesLabel)
        ratesLabel.snp.makeConstraints {
            $0.top.leading.equalTo(Constants.commonOffset)
        }
    }
    
    func configureStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(ratesLabel.snp.bottom).offset(Constants.commonOffset)
            $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: .zero, left: Constants.commonOffset, bottom: .zero, right: Constants.commonOffset))
        }
    }
    
    func configureBookmakerInfo(cellModel: RatesCellModel, bookmaker: RatesCellModel.Bookmaker) {
        let lastElement = cellModel.bookmakers.last
        var infographicViewModel = bookmaker.infographicViewModel
        let infographicView = InfographicMultiColorResultViewImpl(viewModel: infographicViewModel)        
        let bookmakerInfoViewModel = BookmakerInfoViewModelImpl(infographicViewModel: infographicViewModel,
                                                                isHiddenDivider: bookmaker == lastElement,
                                                                amountRates: bookmaker.amountRates + Constants.amountRatesText,
                                                                image: bookmaker.image)
        
        let bookmakerInfoView = BookmakerInfoView(viewModel: bookmakerInfoViewModel, infographicView: infographicView)
        stackView.addArrangedSubview(bookmakerInfoView)
        bookmakerInfoView.snp.makeConstraints {
            $0.height.equalTo(Constants.bookmakerInfoViewHeight)
            $0.width.equalToSuperview()
        }
        infographicViewModel.view = infographicView
    }
}
