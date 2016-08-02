//
//  CycleTabbarView.swift
//  IGO24
//
//  Created by DQ on 16/7/10.
//  Copyright © 2016年 DQ. All rights reserved.
//

import UIKit
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
let kSuspendViewWidth = 60.0 //悬浮主按钮的大小
let kRadius = 100.0 //子按钮 到 主按钮圆心之间的距离
let kButtonDetailWidth = 40.0//子按钮的大小

enum CycleTabbarViewType: Int {
    case Type1 = 0 //这边需要自己改成对应的控制器的名字
    case Type2
    case Type3
    case Type4
}

protocol  CycleTabbarViewDelegate{
    func suspendButtonsAction(type: CycleTabbarViewType)
}


class CycleTabbarView: UIView {
    let buttonRoot = IGOSuspendButton()

    let buttonDetail1 = UIButton()
    let buttonDetail2 = UIButton()
    let buttonDetail3 = UIButton()
    let buttonDetail4 = UIButton()
    var arrayBtn = [UIButton]()
    var touchPoint = CGPointZero
    var isMoiving: Bool = false
    var isShow = false

    var delegate: CycleTabbarViewDelegate?


    // MARK: lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSuspendButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: congifure sub Views
    func configureSuspendButtons()  {

        //====detail buttons

        arrayBtn = [buttonDetail1,buttonDetail2,buttonDetail3,buttonDetail4]
        let arrayTitle = ["1","2","3","4"]
        var index = 0
        for detailBtn in arrayBtn {
            self.addSubview(detailBtn)
            detailBtn.tag = index
            detailBtn.addTarget(self, action: #selector(CycleTabbarView.detailButtonsAction(_:)), forControlEvents: .TouchUpInside)
            detailBtn.setBackgroundImage(UIImage(named: arrayTitle[index]), forState: .Normal)
            index += 1

            detailBtn.snp_makeConstraints(closure: { (make) in
                make.center.equalTo(self.snp_center)
                make.size.equalTo(CGSize(width: kButtonDetailWidth, height: kButtonDetailWidth))
            })


        }
        self.addSubview(buttonRoot)
        buttonRoot.setBackgroundImage(UIImage(named: "+"), forState: .Normal)
        buttonRoot.adjustsImageWhenHighlighted = false
        buttonRoot.addTarget(self, action: #selector(CycleTabbarView.showDetailButtons), forControlEvents: .TouchUpInside)
        buttonRoot.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }



    }
    // MARK: point moving
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         isMoiving = false


    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isMoiving = true

        var touch: UITouch? = nil
        for touchIdx in touches {
            touch = touchIdx
        }
        touchPoint = touch!.locationInView(self.superview)
        UIView.animateWithDuration(0.1) { 
            self.frame.origin = self.touchPoint
        }
        //如果子按钮show 需要hide
        if isShow {
            self.hideDetailButton()
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

//        isMoiving = false
        var touch: UITouch? = nil

        for touchIdx in touches {
            touch = touchIdx
        }
        touchPoint = touch!.locationInView(self.superview)


        //--判断end point 不在 view 上


        //单纯的点击事件
        if isMoiving == false {
            return
        }
        if touchPoint.y < CGFloat(kSuspendViewWidth/2) {
            touchPoint.y = CGFloat(kSuspendViewWidth)
        }
        if touchPoint.y > kScreenHeight - CGFloat(kSuspendViewWidth/2)  {
            touchPoint.y = kScreenHeight - CGFloat(kSuspendViewWidth)
        }
        if touchPoint.x > kScreenWidth/2 {
            UIView.animateWithDuration(0.2, animations: {
                self.frame.origin = CGPoint(x: kScreenWidth - CGFloat(kSuspendViewWidth), y: self.touchPoint.y)

            })
        }else {
            UIView.animateWithDuration(0.2, animations: {
                self.frame.origin = CGPoint(x:0, y: self.touchPoint.y)

            })
        }

    }

    func showDetailButtons()  {


        if !isMoiving {
            //处理点击事件
            if isShow {
                self.hideDetailButton()
            }else {
                isShow = true
            if touchPoint.x > kScreenWidth/2 {
                //左边出现
//                for detailButton in arrayBtn {
//                    detailButton.hidden = false
//                }

                UIView.animateWithDuration(0.3, animations: {
                    self.buttonRoot.transform = CGAffineTransformRotate(self.buttonRoot.transform, CGFloat(M_PI_4))

                    self.buttonDetail1.snp_updateConstraints { (make) in

                        make.center.equalTo( CGPoint(x: -kRadius , y: 0))

                    }
                    self.buttonDetail2.snp_updateConstraints { (make) in
                        make.center.equalTo( CGPoint(x: -kRadius * cos(M_PI/6) , y:  -kRadius*cos(M_PI/3)))



                    }
                    self.buttonDetail3.snp_updateConstraints { (make) in
                        make.center.equalTo( CGPoint(x: -kRadius*cos(M_PI/3) , y:  -kRadius*cos(M_PI/6)))


                    }
                    self.buttonDetail4.snp_updateConstraints { (make) in

                        make.center.equalTo( CGPoint(x:0 , y:  -kRadius))
                    }
                    self.layoutIfNeeded()
                })

            } else {
                //右边出现

                UIView.animateWithDuration(0.3, animations: {
                    self.buttonRoot.transform = CGAffineTransformRotate(self.buttonRoot.transform, CGFloat(M_PI_4))
                    self.buttonDetail1.snp_updateConstraints { (make) in
                        make.center.equalTo( CGPoint(x: kRadius , y: 0))

                    }
                    self.buttonDetail2.snp_updateConstraints { (make) in
                        make.center.equalTo( CGPoint(x: kRadius * cos(M_PI/6) , y:  -kRadius*cos(M_PI/3)))


                    }
                    self.buttonDetail3.snp_updateConstraints { (make) in
                        make.center.equalTo( CGPoint(x: kRadius*cos(M_PI/3) , y:  -kRadius*cos(M_PI/6)))

                    }
                    self.buttonDetail4.snp_updateConstraints { (make) in

                        make.center.equalTo( CGPoint(x:0 , y:  -kRadius))
                    }
                    self.layoutIfNeeded()
                })

            }
            }
        }
    }

    func hideDetailButton()  {
        isShow = false
        UIView.animateWithDuration(0.3) {
            self.buttonRoot.transform = CGAffineTransformRotate(self.buttonRoot.transform, CGFloat(-M_PI_4))
            for detailBtn in self.arrayBtn {
                detailBtn.snp_updateConstraints(closure: { (make) in
                    make.center.equalTo(self.snp_center)


                })

        }
              self.layoutIfNeeded()
        }
    }


    // MARK: detail buttons action
    func detailButtonsAction(sender: UIButton)  {
        let type = CycleTabbarViewType(rawValue: sender.tag)
        delegate?.suspendButtonsAction(type!)
    }


    // MARK: 处理detail btn 超出父视图 不响应事件
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, withEvent: event)
        if view == nil {
            if !self.hidden  {
            if CGRectContainsPoint(buttonDetail1.frame,point) {
                view = buttonDetail1
            }else if CGRectContainsPoint(buttonDetail2.frame,point) {
                view = buttonDetail2
            }else if CGRectContainsPoint(buttonDetail3.frame,point) {
                view = buttonDetail3
            }else if CGRectContainsPoint(buttonDetail4.frame,point) {
                view = buttonDetail4
            }
            }


        }
        return view

    }


}
