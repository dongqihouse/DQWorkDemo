//
//  IGOSuspendButton.swift
//  IGO24
//
//  Created by DQ on 16/7/12.
//  Copyright © 2016年 DQ. All rights reserved.
//

import UIKit

class IGOSuspendButton: UIButton {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
        super.touchesBegan(touches, withEvent: event)

    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nextResponder()?.touchesMoved(touches, withEvent: event)
        super.touchesMoved(touches, withEvent: event)

    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nextResponder()?.touchesEnded(touches, withEvent: event)
        super.touchesEnded(touches, withEvent: event)

    }

}
