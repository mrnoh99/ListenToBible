//
//  MiddleView.swift
//  ListenToBible
//
//  Created by NohJaisung on 2018. 1. 29..
//  Copyright © 2018년 NohJaisung. All rights reserved.
//


import UIKit

@IBDesignable

class MiddleView: UIView {

   
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        UIColor.white.setFill()
        roundRect.fill()
    }
    

}
extension MiddleView {
    private struct SizeRatio {
        static let cornerFontSizetoBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
        
    }
    private var cornerRadius:CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizetoBoundsHeight
    }
}
