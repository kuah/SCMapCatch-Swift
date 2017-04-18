//
//  Dictionary+SC.swift
//  SCMapCatch-Swift_Demo
//
//  Created by 陈世翰 on 17/4/18.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import Foundation

extension Dictionary{
    mutating func mc_set(value:Value?,forkey key:Key)->Dictionary{
        var result = self as [Key:Value]
        if value != nil{
            result[key] = value!
        }else{
            removeValue(forKey: key)
        }
        return result
    }
    func mc_object<T:Hashable>(forKeys keys:Array<T>) -> Any? {
        guard keys.count>0 else{
            return nil
        }
        if keys.count == 1{
            return self[keys.first as! Key]
        }else{
            let nextLevel = self[keys.first as! Key]
            guard nextLevel != nil && nextLevel is [Key:Value] else{
                return nil
            }
            var nextLevelKeys = keys
            nextLevelKeys.remove(at: 0)
            return (nextLevel as! [Key:Value]).mc_object(forKeys: nextLevelKeys)
        }
    }
    func mc_object<T:Hashable>(forKeys keys:T...) -> Any? {
        return mc_object(forKeys:keys)
    }
}
