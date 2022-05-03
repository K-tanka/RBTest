//
//  UITableView+Extension.swift
//  RBTest
//
//  Created by Tatty on 30.04.2022.
//
import UIKit

extension UITableView {

    func dequeue <T: UITableViewCell>(reusable identifier: T.Type, for indexPath: IndexPath) -> T {
        let identifierString = String(describing: identifier)
        return dequeueReusableCell(withIdentifier: identifierString, for: indexPath) as! T
    }
}
