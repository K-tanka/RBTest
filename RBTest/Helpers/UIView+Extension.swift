//
//  UIView+Extension.swift
//  RBTest
//
//  Created by Tatty on 01.05.2022.
//
import UIKit

extension UIView {
    
    func createBorder(height: CGFloat, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, color: UIColor) {
        let border = getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                     y: frame.height - height,
                                                     width: frame.width + rightOffset,
                                                     height: height),
                                       color: color)
        self.layer.addSublayer(border)
    }
    
    private func getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border:CALayer = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }
}
