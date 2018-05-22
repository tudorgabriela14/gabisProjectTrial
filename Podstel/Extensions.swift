//
//  Extensions.swift
//  CGT
//
//  Created by Jingoiu Iulia on 2/22/18.
//  Copyright © 2018 Joomla. All rights reserved.
//

import Foundation
import UIKit
import Parse

public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
}
public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]){
            uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Swift.Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension Data {
    
    var utf8String: String? {
        return string(as: .utf8)
    }
    
    func string(as encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
}
extension NSError {

    func customizedParseError() -> NSError? {

        guard domain == PFParseErrorDomain && code == PFErrorCode.scriptError.rawValue else { return nil }

        guard let description = userInfo[NSLocalizedDescriptionKey] as? Dictionary<String,Any> else { return nil }

        guard let code = description["code"] as? Int else { return nil }
        guard let message = description["message"] as? String else { return nil }

        return NSError(domain: domain,
                       code: code,
                       userInfo: [
                        NSLocalizedDescriptionKey:message,
                        NSLocalizedFailureReasonErrorKey:message,
                        ])
    }
}

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(_ comment:String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    var length: Int {
        return self.characters.count
    }
    
    var isValidEmail: Bool {
        guard self.length >= 5 else { return false } //1@3.5
        let regexString = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}+$"
        
        do {
            let regex = try NSRegularExpression(pattern: regexString, options: .init(rawValue: 0))
            guard let rangeOfFirstMatch = regex.firstMatch(in: self, options: .init(rawValue: 0), range: NSMakeRange(0, self.length)) else  { return false }
            if rangeOfFirstMatch.range.location != NSNotFound {
                return true
            }
        } catch let error {
            print(error)
        }
        
        return false
    }
}


extension UITextField {
    
    var isNotEmpty:Bool {
        return self.text != nil && !self.text!.isEmpty
    }
    
    var isValidEmail: Bool {
        guard let text = self.text else { return false }
        return text.isValidEmail
    }
}

extension UIView {
    func applyShadow(_ value:CGFloat = 5) {
        self.layer.shadowOffset = CGSize(width: 0, height: value * 0.4)
        self.layer.shadowOpacity = Float(value * 0.1)
        self.layer.shadowRadius = value
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func prepareForAutolayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    fileprivate func _addGradientBackgroundWithStartColor(startColor:UIColor, endColor:UIColor, clockDirection hourDirection:Float) -> CALayer {
        
        self.backgroundColor = .clear
        
        let gradLayer = CAGradientLayer()
        gradLayer.frame = self.bounds
        
        var sx:CGFloat = 0.0,sy:CGFloat = 0.0,ex:CGFloat = 0.0,ey:CGFloat = 0.0
        
        var hour = CGFloat(hourDirection)
        if (hour < 0) {
            hour = CGFloat(720-(Int(-hour*60)%720)) / CGFloat(60.0)
        }
        
        if ((hour-12)>0) {
            hour-=12
        }
        
        
        var angle = Double((Int(hour*60)) % 720) * M_PI / 360.0
        
        var factor:CGFloat = 1.0
        
        while (!(angle < M_PI)) {
            angle = angle - M_PI
            factor = factor * -1
        }
        
        
        if (angle == 0.0) {
            ey = 0.5
            ex = 0
            sy = -0.5
            sx = 0
        }
            
        else if (angle<M_PI_4) {
            ey = 0.5
            ex = CGFloat(atan(M_PI_4-angle) * 0.5)
            sx = -ex
            sy = -ey
        }
        else if (angle==M_PI_4) {
            sx = -0.5
            sy = -0.5
            ex = 0.5
            ey = 0.5
        }
        else if (angle<M_PI_2) {
            ex = 0.5
            ey = CGFloat(tan(M_PI_2-angle) * 0.5)
            sx = -0.5
            sy = -ey
        }
            
        else if (angle==M_PI_2) {
            ex = 0.5
            ey = 0
            sx = -0.5
            sy = 0
        }
            
        else if (angle<M_PI_4*3) {
            ex = 0.5
            ey = CGFloat(-tan(angle-M_PI_2) * 0.5)
            sx = -0.5
            sy = -ey
        }
            
        else if (angle==M_PI_4*3) {
            ex = 0.5
            ey = -0.5
            sx = -0.5
            sy = 0.5
        }
            
        else if (angle<Double.pi) {
            ey = -0.5
            ex = CGFloat(atan(angle-M_PI_4)*0.5)
            sx = -ex
            sy = 0.5
        }
        
        ex = ex*factor+0.5
        ey = -ey*factor+0.5
        sx = sx*factor+0.5
        sy = -sy*factor+0.5
        
        gradLayer.startPoint = CGPoint(x:sx, y:sy)
        gradLayer.endPoint = CGPoint(x:ex, y:ey)
        
        
        gradLayer.colors = [startColor.cgColor,endColor.cgColor]
        
        gradLayer.cornerRadius = self.layer.cornerRadius
        
        layer.insertSublayer(gradLayer, at: 0)
        
        return gradLayer
    }
}


class GradientView:UIView {
    var gradientLayer:CALayer?

    func addGradientBackgroundWithStartColor(startColor:UIColor, endColor:UIColor, clockDirection hourDirection:Float) {
        
        clipsToBounds = true
        
        self.isUserInteractionEnabled = false
        if gradientLayer == nil {
            gradientLayer = _addGradientBackgroundWithStartColor(startColor: startColor, endColor: endColor, clockDirection: hourDirection)
        }
    }
    override var frame: CGRect {
        didSet {
            if gradientLayer != nil {
                gradientLayer?.frame = bounds
            }
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if let newSuperview = newSuperview {
            layer.cornerRadius = newSuperview.layer.cornerRadius
        }
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        if gradientLayer != nil {
            gradientLayer?.frame = bounds
        }
    }
}

extension UIColor {
    convenience init(_ r: Int,_ g: Int,_ b: Int,_ a: CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
}

extension UIImage {
    func scaledImage(_ newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    convenience init(view: UIView) {    
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

extension DateFormatter {
    fileprivate static let MyCollectionFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
    //... more formats
}

extension Date {
    func myCollectionString() -> String {
        return DateFormatter.MyCollectionFormat.string(from: self as Date)
    }
}

extension NSDate {
    func myCollectionString() -> String {
        return DateFormatter.MyCollectionFormat.string(from: self as Date)
    }
}

extension UICollectionView {
    
    func setupSquareLayout(_ leftMargin:CGFloat, _ rightMargin:CGFloat, _ itemCountInRow:Int, _ itemSpacingWidthProprotion:CGFloat, _ makeRound:Bool) {
        
        let ScreenWidth = UIScreen.main.bounds.width
        
        //w = item width to calculate
        //ScreenWidth = leftMargin + w * itemCountInRow + itemSpacing * (itemCountInRow-1) + rightMargin
        //itemSpacing ≈ w * itemSpacingWidthProprotion
        //=> ScreenWidth = leftMargin + w * itemCountInRow + w * itemSpacingWidthProprotion * (itemCountInRow-1) + rightMargin
        
        //Expression was too complex to be solved in reasonable time consider breaking the expression into distinct sub-expressions
        let a = ScreenWidth - leftMargin - rightMargin
        let b = CGFloat(itemCountInRow) * (itemSpacingWidthProprotion + 1.0) - itemSpacingWidthProprotion
        let w_fraction = a / b
        
        var w = ceil(w_fraction)
        
        if Int(w) % 2 == 1 {
            w += 1
        }
        
        let itemSpacing_fraction = (ScreenWidth - 32 - w * CGFloat(itemCountInRow)) / (CGFloat(itemCountInRow) - 1.0)
        
        let itemSpacing = floor(itemSpacing_fraction)
        
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: w, height: w)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        
        var contentInset = self.contentInset
        contentInset.left = leftMargin
        contentInset.right = rightMargin
        self.contentInset = contentInset
        
        if makeRound {
            let visibleCells = self.visibleCells
            for cell in visibleCells {
                let v_color = cell.contentView.subviews.first
                let v_selectedColor = cell.contentView.subviews.last
                
                v_color?.layer.cornerRadius = w / 2.0
                v_selectedColor?.layer.cornerRadius = w / 2.0 - 3.0
                
            }
        }
        
    }
}


extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

public extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return Int((self as NSString).intValue)
    }
}

public extension UIImage {
    func tintImage(fillColor: UIColor) -> UIImage {
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)
            
            // draw original image
            context.setBlendMode(.normal)
            context.draw(cgImage!, in: rect)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            fillColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(context.makeImage()!, in: rect)
        }
    }
    
    fileprivate func modifiedImage(_ draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
