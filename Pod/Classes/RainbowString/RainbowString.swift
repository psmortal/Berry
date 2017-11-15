//
//  RainbowString.swift
//  tianshidaoyi
//
//  Created by ydf on 2017/8/11.
//  Copyright © 2017年 zengdaqian. All rights reserved.
//

import Foundation

public extension String {
    
    public var rb:Rainbow{
        return Rainbow(self)
    }
}

public extension String{
    
    public subscript(_ range:CountableClosedRange<Int>)->String{
        
        return (self as NSString).substring(with: NSMakeRange(range.lowerBound, range.upperBound - range.lowerBound + 1))
    }
    
    
    public func locations(of:String)->[Int]{
        
        var result = [Int]()
        if !contains(of) || of.characters.count == 0 || self.characters.count < of.characters.count {return []}
        for i in 0...(characters.count - of.characters.count){
            
            if self[i...(i + of.characters.count - 1)] == of {
                result.append(i)
            }
        }
        
        return result
    }
}

public class Rainbow {
    
    public let base:String
    private let attributedString:NSMutableAttributedString
    var operatingString:String? // 当前操作的子字符串
    var operatingRanges:[NSRange] //当前操作的range
    
    var attributes:[String:Any] = [:]
    
    public func match(_ subString:String)->Rainbow{
        
        self.operatingString = subString
        
        if base.contains(subString){
            self.operatingRanges = base.locations(of: subString).map{NSMakeRange($0, subString.characters.count)}
        }else{
            self.operatingRanges = []
        }
        return self
    }
    
    public func all()->Rainbow{
        
        return match(base)
    }
    
    public subscript(_ range:CountableClosedRange<Int>)->Rainbow{
        
        self.operatingRanges = [NSMakeRange(range.lowerBound, range.upperBound - range.lowerBound + 1)]
        return self
    }
    
    public func range(_ range:CountableClosedRange<Int>)->Rainbow{
        
        self.operatingRanges = [NSMakeRange(range.lowerBound, range.upperBound - range.lowerBound + 1)]
        return self
    }
    
    init(_ base:String) {
        
        self.base = base
        self.attributedString = NSMutableAttributedString(string: base)
        self.operatingRanges = [NSMakeRange(0, base.characters.count)]
    }
    
    
    
    public var done:NSMutableAttributedString{
        
        return attributedString
    }
    
    public func fontSize(_ size:CGFloat)->Rainbow{
        
        for range in operatingRanges{
            attributedString.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: size)], range:range)
        }
        return self
    }
    
    
    public func font(_ font:UIFont)->Rainbow{
        
        for range in operatingRanges{
            attributedString.addAttributes([NSFontAttributeName:font], range:range)
        }
        return self
    }
    
    public func color(_ color:UIColor)->Rainbow{
        
        for range in operatingRanges{
            attributedString.addAttributes([NSForegroundColorAttributeName:color], range:range)
        }
        return self
    }
    
    
}







