//
//  ControllersFactory.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import Foundation

enum ControllersFactory {
    
    static func initInfoViewController() -> InfoViewController {
        
        let viewModel = InfoViewModelImpl()
        let controller = InfoViewController(viewModel: viewModel)
        return controller
    }
}
