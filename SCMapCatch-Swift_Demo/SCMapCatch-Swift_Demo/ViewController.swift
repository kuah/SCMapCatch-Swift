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
        UserDefaults.mc_set(object: "111111", forKeys: "1","2","a6","a7")
        let obj = UserDefaults.standard.mc_object(forKeys: "1","2","a6","a7")
        print("catch0 -----> \(obj!)")
        
        
        let dic = ["1":["2":["3":"fdasfads"]]]
        let catchResult = dic.mc_object(forKeys: "1","2","3")
        
        print("catch1 -----> \(catchResult!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

