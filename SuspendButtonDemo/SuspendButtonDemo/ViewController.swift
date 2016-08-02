//
//  ViewController.swift
//  SuspendButtonDemo
//
//  Created by DQ on 16/8/2.
//  Copyright © 2016年 DQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CycleTabbarViewDelegate {
    var suspendButton: CycleTabbarView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        suspendButton = CycleTabbarView(frame: CGRect(x: 0, y: 130, width: 60, height: 60) )
        suspendButton?.delegate = self
        self.view.addSubview(suspendButton!)
    }
    func suspendButtonsAction(type: CycleTabbarViewType) {
        switch type {
        case .Type1:
            let alertVC = UIAlertController(title: "11", message: "22", preferredStyle: .Alert)
            alertVC.addAction(UIAlertAction(title: "sure", style: .Cancel, handler: nil))
            self.presentViewController(alertVC, animated: true, completion: nil)
        case .Type2:
            print("")
        case .Type3:
            print("")
        case .Type4:
            print("")

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

