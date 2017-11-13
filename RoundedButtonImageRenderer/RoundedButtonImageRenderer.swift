import Foundation
import UIKit

public struct RoundedButtonImageRenderer {
    public static func renderImage(text: String, layout: LayoutSpecs, colors: ColorSpecs) -> UIImage? {
        let renderer = RoundedButtonImageRenderer()
        let attributes = renderer.makeAttributes(font: layout.font, text: colors.text)
        let textSize = renderer.makeTextSize(text: text, attributes: attributes)
        let textFrame = renderer.makeTextFrame(specs: layout, textSize: textSize)
        let roundedFrame = renderer.makeRoundedRectFrame(specs: layout, textSize: textSize)
        let imageSize = CGSize(
            width: layout.margin + roundedFrame.width + layout.margin,
            height:  layout.margin + roundedFrame.height + layout.margin
        )
        return renderer.render(
            string: text,
            size: imageSize,
            background: colors.background,
            fill: colors.fill,
            roundedRectFrame: roundedFrame,
            textFrame: textFrame,
            attributes: attributes,
            cornerRadius: layout.cornerRadius,
            lineWidth: layout.borderWidth,
            lineColor: colors.border
        )
    }
}

public extension RoundedButtonImageRenderer {
    public struct ColorSpecs {
        let border: UIColor?
        let background: UIColor
        let fill: UIColor
        let text: UIColor
        
        public init(border: UIColor? = nil, background: UIColor, fill: UIColor, text: UIColor) {
            self.border = border
            self.background = background
            self.fill = fill
            self.text = text
        }
    }
    
    public struct LayoutSpecs {
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let margin: CGFloat
        let paddingH: CGFloat
        let paddingV: CGFloat
        let font: UIFont
        
        public init(
            cornerRadius: CGFloat,
            borderWidth: CGFloat,
            margin: CGFloat,
            paddingH: CGFloat,
            paddingV: CGFloat,
            font: UIFont)
        {
            self.cornerRadius = cornerRadius
            self.borderWidth = borderWidth
            self.margin = margin
            self.paddingH = paddingH
            self.paddingV = paddingV
            self.font = font
        }
    }
}

private extension RoundedButtonImageRenderer {
    func makeTextSize(text: String, attributes: [String: Any]) -> CGSize {
        let string = NSString(string: text)
        let rawTextSize = string.size(attributes: attributes)
        return CGSize(width: ceil(rawTextSize.width), height: ceil(rawTextSize.height))
    }
    
    func makeTextFrame(specs: LayoutSpecs, textSize: CGSize) -> CGRect {
        return CGRect(
            x: specs.margin + specs.borderWidth + specs.paddingH,
            y: specs.margin + specs.borderWidth + specs.paddingV,
            width: textSize.width,
            height: textSize.height
        )
    }

    func makeRoundedRectFrame(specs: LayoutSpecs, textSize: CGSize) -> CGRect {
        return CGRect(
            x: specs.margin,
            y: specs.margin,
            width: specs.borderWidth + specs.paddingH + textSize.width + specs.paddingH + specs.borderWidth,
            height: specs.borderWidth + specs.paddingV + textSize.height + specs.paddingV + specs.borderWidth
        )
    }
    
    func makeAttributes(font: UIFont, text: UIColor) -> [String: AnyObject] {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: text,
            NSParagraphStyleAttributeName: style
        ]
    }
    
    func render(
        string: String,
        size: CGSize,
        background: UIColor,
        fill: UIColor,
        roundedRectFrame: CGRect,
        textFrame: CGRect,
        attributes: [String: Any],
        cornerRadius: CGFloat,
        lineWidth: CGFloat,
        lineColor: UIColor?) -> UIImage?
    {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(background.cgColor)
            context.fill(CGRect(origin: .zero, size: size))
            context.addPath(UIBezierPath(roundedRect: roundedRectFrame, cornerRadius: cornerRadius).cgPath)
            context.setFillColor(fill.cgColor)
            context.fillPath()
            if let lineColor = lineColor {
                context.setLineWidth(lineWidth)
                context.setStrokeColor(lineColor.cgColor)
                context.addPath(UIBezierPath(roundedRect: roundedRectFrame, cornerRadius: cornerRadius).cgPath)
                context.strokePath()
            }
            string.draw(in: textFrame, withAttributes: attributes)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
