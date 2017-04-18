//
//  ViewController.swift
//  SCMapCatch-Swift_Demo
//
//  Created by 陈世翰 on 17/4/17.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.mc_set(object: 1, forKeys: "a4","a8","a6","a7")
        UserDefaults.mc_set(object: "1", forKeys: "a4","a8","a6","a7")
        UserDefaults.mc_set(object: 1, forKeys: "b","b2")
        let obj = UserDefaults.standard.mc_object(forKeys: ["a4","a8","a6","a7"])
        print(obj!)
//        var dic = [String:Any]()
//        dic = dic.mc_set(value: 1, forkey: "4")
//        print(dic)
//        let dic0 = ["1":["1":223],"2":2,"3":3,"4":4,"5":5,"6":6] as [String:Any]!
//        print(dic0!.mc_object(forKeys: ["1","1"])!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

