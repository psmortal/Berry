//
//  Extentions.swift
//  Zuzhong
//
//  Created by mortal on 2016/12/13.
//  Copyright © 2016年 矩点医疗科技有 限公司. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1) {
        self.init(red:r/255.0,green:g/255.0,blue:b/255.0,alpha:a)
    }
    
}

extension UIImage {
    
    convenience init(color: UIColor, size: CGSize = CGSize(width:1, height:1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage:(image?.cgImage)!)
       
    }
    
    
    //MARK: - 截屏scrollView
    static func capture(scrollView:UIScrollView)->UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 2)
        let soffset = scrollView.contentOffset
        let sframe = scrollView.frame
        
        scrollView.contentOffset = CGPoint.zero
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        scrollView.contentOffset = soffset
        scrollView.frame = sframe
        UIGraphicsEndImageContext()
        return image
    }
    
    func scale(to:CGFloat)->UIImage?{
        
        UIGraphicsBeginImageContext(CGSize(width: size.width * to, height: size.height * to))
        draw(in: CGRect(x: 0, y: 0, width: size.width * to, height: size.height * to))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func cutBottom(offSetX:CGFloat = 0,offSetY:CGFloat = 0) -> UIImage {
        var newRect = CGRect(x: offSetX, y: offSetY, width: self.size.width, height: self.size.width)
        if self.size.height < self.size.width {
            newRect = CGRect(x: offSetX, y: offSetY, width: self.size.height, height: self.size.height)
        }
        let cgimg = self.cgImage!.cropping(to: newRect)
        let image = UIImage(cgImage: cgimg!)
        
        return image
    }
}



extension UINavigationBar {
    
    /**
     隐藏Bar底部黑线
     */
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = true
    }
    /**
     显示Bar底部黑线
     */
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}


extension UIToolbar {
    
    /**
     隐藏Bar顶部黑线
     */
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    /**
     显示Bar顶部黑线
     */
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

extension UIView {
    /**
     为View添加圆形Mask
     */
    func makeRoundMask() {
        let maskLayer = CAShapeLayer()
        let roundPath = UIBezierPath(ovalIn: bounds)
        maskLayer.path = roundPath.cgPath
        layer.mask = maskLayer
    }
}

extension UIViewController {
    
    typealias AlertAction = () -> Void
    
    func showAlertView(
        title: String = "温馨提示", message: String? = nil,
        confirmButton: String = "确定", cancleButton: String?,
        confirmAction: AlertAction? = nil, cancleAction: AlertAction? = nil) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmButton, style: .default) { (alertAction) -> Void in
            confirmAction?()
        }
        alertVC.addAction(confirmAction)
        
        if let cancleB = cancleButton {
            let cancleAction = UIAlertAction(title: cancleB, style: .cancel, handler: { (alertAction) -> Void in
                cancleAction?()
            })
            alertVC.addAction(cancleAction)
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
}


// MARK: - tableView可刷新扩展

enum RefreshType {
    case Head
    case Foot
}


extension String {
    var url : URL?{
        return URL(string:self)
    }
}

extension String {
    
    func matchWith(pattern: String) throws -> Bool {
        
        struct RegexHelper {
            let regex: NSRegularExpression
            
            init(_ pattern: String) throws {
                try regex = NSRegularExpression(pattern: pattern,
                                                options: .caseInsensitive)
            }
            
            func match(input: String) -> Bool {
                let matches = regex.matches(in: input,
                                                    options: [],
                                                    range: NSMakeRange(0, input.characters.count))
                return matches.count > 0
            }
        }
        
        let matcher: RegexHelper
        do {
            matcher = try RegexHelper(pattern)
        }
        return matcher.match(input: self)
    }
    
    /// 验证身份证号码
    var isIDCard: Bool {
        let pattern = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
        do {
            return try matchWith(pattern: pattern)
        } catch {
            print("正则表达式错误")
            return false
        }
    }
    

}





extension UIBarButtonItem {
    
    static func yz_negativeSpacer(width: CGFloat) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = (width >= 0 ? -width : width)
        return item
    }
    
}


extension UIViewController {
    
    func yz_setRightBarButton(image: UIImage, target: AnyObject?, action: Selector) {
        
        let spaceItem = UIBarButtonItem.yz_negativeSpacer(width: 13)
        
        let item = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        
        let items = [spaceItem, item]
        self.navigationItem.setRightBarButtonItems(items, animated: false)
    }
}





extension Double {
    
    var RMB : String? {
        return String(format:"¥%.2f",self)
    }
}


//JSONArray的拼接

//extension JSON {
//    func appendJSONArray(aJsonArray:JSON?) -> JSON {
//        if var temp = self.array {
//            if let dataArr = aJsonArray?.array{
//                temp.appendContentsOf(dataArr)
//            }
//            return JSON(temp)
//        }else{
//            return self
//        }
//    }
//}






//extension UITableView {
//    override public class func initialize(){
//        
//        if self != UITableView.self {return}
//        
//        struct swizzleToken{
//            static var onceToken:dispatch_once_t = 0
//        }
//        
//        dispatch_once(&swizzleToken.onceToken) {
//            let cls:AnyClass = UITableView.self
//            
//            let originalSEL = #selector(UITableView.reloadData)
//            
//            let swizzleSEL = #selector(UITableView.swizzle_reloadData)
//            
//            let originalFunc = class_getInstanceMethod(cls, originalSEL)
//            let swizzleFunc = class_getInstanceMethod(cls, swizzleSEL)
//            
//            method_exchangeImplementations(originalFunc, swizzleFunc)
//            
//            
//        }
//    }
//    
//    func swizzle_reloadData(){
//        
//        swizzle_reloadData()
//        
//        var num = 0
//        guard numberOfSections > 0 else{
//            return
//        }
//        for section in 0...numberOfSections - 1 {
//            num += numberOfRowsInSection(section)
//        }
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        if !(appDelegate.manager!.isReachable) {
//            
//        }
//        
//        if num != 0 {
//            //有数据
//        }else{
//            //无数据
//        }
//    }
//}
//
//
//
