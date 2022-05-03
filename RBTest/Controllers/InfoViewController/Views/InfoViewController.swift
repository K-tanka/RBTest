//
//  InfoViewController.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import UIKit
import SnapKit

final class InfoViewController: UIViewController {
    
    private enum Constants {
        static let coefficientsReuseIdentifier = "CoefficientsCell"
        static let ratesReuseIdentifier = "RatesCell"
        static let commonOffset = 5.0
        static let sectionHeaderHeight = 10.0
        static let sectionFooterHeight = 0.0
        static let estimatedRowHeight = 300.0
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.sectionHeaderHeight = Constants.sectionHeaderHeight
        tableView.sectionFooterHeight = Constants.sectionFooterHeight
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: Constants.sectionHeaderHeight)))
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoefficientsCell.self, forCellReuseIdentifier: Constants.coefficientsReuseIdentifier)
        tableView.register(RatesCell.self, forCellReuseIdentifier: Constants.ratesReuseIdentifier)
        return tableView
    }()
    
    private var viewModel: InfoViewModel
    
    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
}

extension InfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = indexPath.section == 0 ? tableView.dequeue(reusable: CoefficientsCell.self, for: indexPath) : tableView.dequeue(reusable: RatesCell.self, for: indexPath)
        configureCell(cell, section: indexPath.section)
        return cell
    }
}

private extension InfoViewController {
    
    func setupUIElements() {
        view.backgroundColor = .gray
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: .zero, left: Constants.commonOffset, bottom: .zero, right: Constants.commonOffset))
            $0.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureCell(_ cell: UITableViewCell, section: Int) {
        if section == 0 {
            guard let cell = cell as? ConfigurableCoefficients, let cellModel = viewModel.createCellModel(for: section) as? CoefficientsCellModel else { return }
            cell.configure(cellModel)
        } else {
            guard let cell = cell as? ConfigurableRates, let cellModel = viewModel.createCellModel(for: section) as? RatesCellModel else { return }
            cell.configure(cellModel)
        }
    }
}
