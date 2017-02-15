//
//  KeyboardManager.swift
//  Zuzhong
//
//  Created by mortal on 2016/12/22.
//  Copyright © 2016年 矩点医疗科技有 限公司. All rights reserved.
//

import Foundation
import UIKit

public class KeyboardManager {
    
    static var shared:KeyboardManager = KeyboardManager()
    var scrollView:UIScrollView?
    
    private init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShowNotification(notification:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHideNotification(notification:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardDidShowNotification(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom:keyboardSize.height, right: 0)
            self.scrollView?.contentInset = contentInsets
        }
    }
    
    @objc func keyboardDidHideNotification(notification: NSNotification) {
        
        self.scrollView?.contentInset = UIEdgeInsets.zero
    }
    
    
    
    
    func regist(scrollView:UIScrollView){
        
        self.scrollView = scrollView
    }
}
