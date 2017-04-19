
//  UserDefault+MC.swift
//  SCMapCatch-Swift_Demo
//
//  Created by 陈世翰 on 17/4/17.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import Foundation

extension UserDefaults{
    /*
     UserDefaults set object by level keys , it will auto choose to create elements on the path if the elements on the path have not been created,or delete the element on the path when the param 'object' is nil
     :mObject:object to insert
     :keys:path components
     :warning:The first obj in keys must be 'Stirng' type ，otherwise it will return nil
     */
   func mc_set<T:Hashable>(object mObject:Any?,forKeys keys:Array<T>){
        guard keys.count>0 else {
            return
        }
        guard keys.first != nil else{
            return
        }
        let firstKey = keys.first as? String//第一个key必须为string userDefault规定
        guard firstKey != nil else{
            return
        }
        
        if keys.count==1{
            mc_set(object: mObject, forkey: firstKey!)
        }else{
            let tree = value(forKey:firstKey!)
            var mDict = [T : Any]()
            
            if tree != nil {
                guard tree is [T:Any] else {
                    return
                }
                mDict = tree as! [T : Any]
            }
            var inputKeys = keys
            inputKeys.remove(at: 0)
            let rootTree = mc_handleTree(tree: mDict, components: inputKeys , obj: mObject)
            guard rootTree != nil else {
                return
            }
            set(rootTree!, forKey: firstKey!)
        }
        synchronize();
    }
    /*
     UserDefaults set object by level keys , it will auto choose to create elements on the path if the elements on the path have not been created,or delete the element on the path when the param 'object' is nil
     :mObject:object to insert
     :keys:path components
     :warning:The first obj in keys must be 'Stirng' type ，otherwise it will return nil
     */
    func mc_set<T:Hashable>(object mObject:Any?,forKeys keys:T...){
        mc_set(object: mObject, forKeys: keys)
    }
    /*
     UserDefaults set object key , it will auto choose to create element when the param 'object' != nil,or delete the element on the path when the param 'object' is nil
     :mObject:object to insert
     :key:String
     */
    func mc_set(object:Any?,forkey key:String){
        if object != nil{
            set(object!, forKey: key)
        }else{
            removeObject(forKey:key)
        }
        synchronize();
    }
    /*Recursive traversal func
     :param:tree this level tree
     :param:components the rest of path components
     :return:hanle result of this level
     */
    fileprivate func mc_handleTree<T:Hashable>(tree: [T:Any],components:Array<T>,obj:Any?)->Dictionary<T, Any>?{
        var result = tree
        if components.count==1{//last level
            result = result.mc_set(value: obj, forkey: components.first!)
        }else{//middle level
            var nextComponents = components
            nextComponents.remove(at: 0)
            let nextTree = tree[components.first!]
            if  nextTree != nil && nextTree is [T : Any]{
                
                result[components.first!] = mc_handleTree(tree:nextTree as! [T : Any], components:nextComponents , obj: obj)
            }else{
                result[components.first!] = mc_handleTree(tree:[T : Any](), components:nextComponents , obj: obj)
            }
        }
        return result
    }
    
    class func mc_set(object:Any?,forkey key:String){
        self.standard.mc_set(object: object, forkey: key)
    }
    class func mc_set<T:Hashable>(object mObject:Any?,forKeys keys:T...){
        self.standard.mc_set(object: mObject, forKeys: keys)
    }
    class func mc_set<T:Hashable>(object mObject:Any?,forKeys keys:Array<T>){
        self.standard.mc_set(object: mObject, forKeys: keys)
    }
    
    /*get object by path
     :param:keys path components
     :return:result
     :warning:the first object of keys must be 'String' type , otherwise it will return nil
     */
    func mc_object<T:Hashable>(forKeys keys:T...) -> Any? {
       return mc_object(forKeys: keys)
    }
    /*get object by path
     :param:keys path components
     :return:result
     :warning:the first object of keys must be 'String' type , otherwise it will return nil
     */
    func mc_object<T:Hashable>(forKeys keys:Array<T>) -> Any? {
        guard keys.count>0 else{
            return nil
        }
        let firstKey = keys.first as? String
        guard firstKey != nil  else{
            return nil
        }
        if keys.count == 1{
            return object(forKey: firstKey!)
        }else{
            let nextLevel = object(forKey: firstKey!)
            guard nextLevel != nil && nextLevel is Dictionary<T,Any> else{
                return nil
            }
            var nextLevelKeys = keys
            nextLevelKeys.remove(at: 0)
            return (nextLevel as! Dictionary<T,Any>).mc_object(forKeys: nextLevelKeys)
        }
    }
    class func mc_object<T:Hashable>(forKeys keys:T...) -> Any? {
       return self.standard.mc_object(forKeys: keys)
    }
    class func mc_object<T:Hashable>(forKeys keys:Array<T>) -> Any? {
        return self.standard.mc_object(forKeys: keys)
    }
}
