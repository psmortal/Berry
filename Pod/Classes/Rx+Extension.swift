//
//  Rx+Extension.swift
//  ruiboedu
//
//  Created by mortal on 2017/2/14.
//  Copyright © 2017年 锐博科技. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

public extension Reactive where Base : UIView{
    
    public var transform:UIBindingObserver<Base,CGAffineTransform>{
        
        return  UIBindingObserver(UIElement: self.base, binding: { (view, transform) in
            view.transform = transform
            
        })
    }
}

public extension Reactive where Base :UIRefreshControl{
    
    public var refresh:ControlEvent<Void>{
        
        return controlEvent(UIControlEvents.valueChanged)
    }
}

//infix operator <->
infix operator <-> : DefaultPrecedence
public func <-> <T>(property1: ControlProperty<T>, property2: ControlProperty<T>) -> Disposable{
    
    let c = property1.bindTo(property2.asObserver())
    let d = property2.bindTo(property1.asObserver())
    return Disposables.create(c,d)
}

