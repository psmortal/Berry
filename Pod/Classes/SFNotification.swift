//
//  SFNotification.swift
//  Zuzhong
//
//  Created by mortal on 2016/12/19.
//  Copyright © 2016年 矩点医疗科技有 限公司. All rights reserved.
//

import UIKit

public protocol SFNotification {

    //notificationname
    var name:NSNotification.Name {get}
}

public extension SFNotification {
    
    func post(object anObject: AnyObject? = nil, userInfo aUserInfo: [NSObject : AnyObject]? = nil) {
        
        NotificationCenter.default.post(name:name, object:anObject, userInfo: aUserInfo)
        
    }
    
    func addObserver(observer: AnyObject, selector aSelector: Selector, object anObject: AnyObject?) {
        
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: name, object: anObject)
    }
    
    
}





