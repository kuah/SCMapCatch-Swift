
//  UserDefault+MC.swift
//  SCMapCatch-Swift_Demo
//
//  Created by 陈世翰 on 17/4/17.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import Foundation

extension UserDefaults{
    ///set
    func mc_set(object mObject:Any?,forKeys keys:Array<String>){
        guard keys.count>0 else {
            return
        }
        guard keys.first != nil else{
            return
        }
        if keys.count==1{
            mc_set(object: mObject, forkey: keys.first!)
        }else{
            let tree = value(forKey:keys.first!)
            var mDict = [String : Any]()
            
            if tree != nil {
                guard tree is [String:Any] else {
                    return
                }
                mDict = tree as! [String : Any]
            }
            var inputKeys = keys
            inputKeys.remove(at: 0)
            let rootTree = mc_handleTree(tree: mDict, components: inputKeys, obj: mObject)
            guard rootTree != nil else {
                return
            }
            set(rootTree!, forKey: keys.first!)
        }
        synchronize();
    }
    func mc_set(object mObject:Any?,forKeys keys:String...){
        mc_set(object: mObject, forKeys: keys)
    }
    
    func mc_set(object:Any?,forkey key:String){
        if object != nil{
            set(object!, forKey: key)
        }else{
            removeObject(forKey:key)
        }
        synchronize();
    }
    
    fileprivate func mc_handleTree(tree: [String:Any],components:Array<String>,obj:Any?)->Dictionary<String, Any>?{
        print(components)
        var result = tree
        if components.count==1{//last level
            result = result.mc_set(value: obj, forkey: components.first!)
        }else{//middle level
            var nextComponents = components
            nextComponents.remove(at: 0)
            let nextTree = tree[components.first!]
            if  nextTree != nil && nextTree is [String : Any]{
                
                result[components.first!] = mc_handleTree(tree:nextTree as! [String : Any], components:nextComponents , obj: obj)
            }else{
                result[components.first!] = mc_handleTree(tree:[String : Any](), components:nextComponents , obj: obj)
            }
        }
        print(result)
        return result
    }
    
    class func mc_set(object:Any?,forkey key:String){
        self.standard.mc_set(object: object, forkey: key)
    }
    class func mc_set(object mObject:Any?,forKeys keys:String...){
        self.standard.mc_set(object: mObject, forKeys: keys)
    }
    class func mc_set(object mObject:Any?,forKeys keys:Array<String>){
        self.standard.mc_set(object: mObject, forKeys: keys)
    }
    
    ///get
    func mc_object(forKeys keys:String...) -> Any? {
       return mc_object(forKeys: keys)
    }
    func mc_object(forKeys keys:Array<String>) -> Any? {
        guard keys.count>0 else{
            return nil
        }
        if keys.count == 1{            return object(forKey: keys.first!)
        }else{
            let nextLevel = object(forKey: keys.first!)
            guard nextLevel != nil && nextLevel is Dictionary<String,Any> else{
                return nil
            }
            var nextLevelKeys = keys
            nextLevelKeys.remove(at: 0)
            return (nextLevel as! Dictionary<String,Any>).mc_object(forKeys: nextLevelKeys)
        }
    }
    class func mc_object(forKeys keys:String...) -> Any? {
       return self.standard.mc_object(forKeys: keys)
    }
    class func mc_object(forKeys keys:Array<String>) -> Any? {
        return self.standard.mc_object(forKeys: keys)
    }
}
