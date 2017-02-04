//
//  SFUserdefault.swift
//  Zuzhong
//
//  Created by mortal on 2016/12/19.
//  Copyright © 2016年 矩点医疗科技有 限公司. All rights reserved.
//

import Foundation

protocol SFUserDefault {
    
    var key:String{get}
    
}

extension SFUserDefault {
    
    func value() -> Any? {
        
        return UserDefaults.standard.object(forKey: key)
    }
    
    func setValue(value: AnyObject) {
        
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func remove() {
        
        UserDefaults.standard.removeObject(forKey: key)
    }
}
