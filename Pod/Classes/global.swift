//
//  global.swift
//  Zuzhong
//
//  Created by mortal on 2016/12/13.
//  Copyright © 2016年 矩点医疗科技有 限公司. All rights reserved.
//

import Foundation
import UIKit

let SWIDTH = UIScreen.main.bounds.width
let SHEIGHT = UIScreen.main.bounds.height

//MARK:- 是否模拟器
public struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}


public enum ScreenType {
    case S4_0, S4_7,S5_5,unknown
    
    static func current() -> ScreenType {
        switch SWIDTH{
        case 320.0:
            return ScreenType.S4_0
        case 375.0:
            return ScreenType.S4_7
        case 414.0:
            return ScreenType.S5_5
        default:
            return ScreenType.unknown
        }
    }
}


public func splice(strs:[String?],with:String)->String{
    
    let newStrs = strs.filter{$0 != nil}
    if newStrs.count == 0 {
        return ""
    }
    if newStrs.count == 1{
        return strs[0]!
    }
    var str = ""
    
    
    for i in 0...newStrs.count - 1 {
        
        if newStrs[i] != nil && str.characters.count > 0{
            str += with + newStrs[i]!
        }
        if newStrs[i] != nil && str.characters.count == 0 {
            str += newStrs[i]!
        }
        if newStrs[i] == nil {
            continue
        }
    }
    return str
}
