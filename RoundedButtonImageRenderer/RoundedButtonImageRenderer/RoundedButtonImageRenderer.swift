//  RoundedButtonImageRenderer.swift
//  Created by Fernando Olivero on 26/03/2017.
//  Copyright © 2017 Fernando Olivero. All rights reserved.
import Foundation
import UIKit

public struct RoundedButtonImageRenderer {
    let borderWidth: CGFloat?
    let borderColor: UIColor?
    let backgroundColor: UIColor
    let fillColor: UIColor
    let margin: CGFloat
    let paddingH: CGFloat
    let paddingV: CGFloat
    let text: String
    let textColor: UIColor
    let font: UIFont
    let cornerRadius: CGFloat
    
    var image: UIImage? {
        var image: UIImage?
        let lineW: CGFloat = borderWidth ?? 0.0
        
        let string = NSString(string: text)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: style
        ]
        let rawTextSize = string.size(attributes: attributes)
        let textSize = CGSize(width: ceil(rawTextSize.width), height: ceil(rawTextSize.height))
        
        let textBox = CGRect(x: margin + lineW + paddingH, y: margin + lineW + paddingV, width: textSize.width, height: textSize.height)
        
        let roundedRectBox = CGRect(
            x: margin,
            y: margin,
            width: lineW + paddingH + textSize.width + paddingH + lineW,
            height: lineW + paddingV + textSize.height + paddingV + lineW)
        
        let boundingBox = CGRect(
            x: 0.0,
            y: 0.0,
            width: margin + roundedRectBox.width + margin,
            height:  margin + roundedRectBox.height + margin)
        
        UIGraphicsBeginImageContextWithOptions(boundingBox.size, true, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(backgroundColor.cgColor)
            context.fill(boundingBox)
            context.addPath(UIBezierPath(roundedRect: roundedRectBox, cornerRadius: cornerRadius).cgPath)
            context.setFillColor(fillColor.cgColor)
            context.fillPath()
            if let lineColor = borderColor {
                context.setLineWidth(lineW)
                context.setStrokeColor(lineColor.cgColor)
                context.addPath(UIBezierPath(roundedRect: roundedRectBox, cornerRadius: cornerRadius).cgPath)
                context.strokePath()
            }
            string.draw(in: textBox, withAttributes: attributes)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
}
