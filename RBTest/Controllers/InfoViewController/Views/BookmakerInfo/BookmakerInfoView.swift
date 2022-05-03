//
//  BookmakerInfoView.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import UIKit

final class BookmakerInfoView: UIView {
    
    private enum Constants {
        static let commonOffset = 10.0
        static let ratesImageViewHeight = 40.0
        static let ratesImageViewWidth = 80.0
        static let infographicViewHeight = 70.0
        static let font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    private var viewModel: BookmakerInfoViewModel
    private var infographicView: InfographicMultiColorResultView
    
    private lazy var amountRatesLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        return label
    }()
    
    private lazy var ratesImageView: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    init(viewModel: BookmakerInfoViewModel, infographicView: InfographicMultiColorResultView) {
        self.viewModel = viewModel
        self.infographicView = infographicView
        super.init(frame: .zero)
        setupUIElements(amountRates: viewModel.amountRates, image: viewModel.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !viewModel.isHiddenDivider {
            createBorder(height: 2, leftOffset: -10, rightOffset: 20, color: .gray)
        }
    }
}

private extension BookmakerInfoView {
   
    func setupUIElements(amountRates: String, image: UIImage?) {
        configureRatesImageView(image: image)
        configureAmountRatesLabel(amountRates: amountRates)
        configureInfographicView()
    }
    
    func configureRatesImageView(image: UIImage?) {
        addSubview(ratesImageView)
        ratesImageView.image = image
        ratesImageView.snp.makeConstraints {
            $0.height.equalTo(Constants.ratesImageViewHeight)
            $0.width.equalTo(Constants.ratesImageViewWidth)
        }
    }
    
    func configureAmountRatesLabel(amountRates: String) {
        addSubview(amountRatesLabel)
        amountRatesLabel.text = amountRates
        amountRatesLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratesImageView.snp.centerY)
            $0.leading.equalTo(ratesImageView.snp.trailing).offset(Constants.commonOffset)
        }
    }
    
    func configureInfographicView() {
        addSubview(infographicView)
        infographicView.snp.makeConstraints {
            $0.top.equalTo(ratesImageView.snp.bottom).offset(Constants.commonOffset)
            $0.height.equalTo(Constants.infographicViewHeight)
            $0.width.equalToSuperview()
        }
    }
}
