//
//  View+E.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

private let recognizerAngle = "_recognizerAngle"
private let recognizerScale = "_recognizerScale"

extension UIView {
    public var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            var frame = self.frame
            frame.origin.x = newX
            self.frame = frame
        }
    }
    
    public var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            var frame = self.frame
            frame.origin.y = newY
            self.frame = frame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
    public var right:CGFloat {
        get {
            return self.x + self.width
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.y + self.height
        }
    }
    
    public var scale:CGFloat? {
        get {
            return objc_getAssociatedObject(self, recognizerScale) as? CGFloat
        }
        set (newsCale) {
            objc_setAssociatedObject(self,
                                     recognizerScale, newsCale,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var angle:CGFloat? {
        get {
            return objc_getAssociatedObject(self, recognizerAngle) as? CGFloat
        }
        set (newsAngle) {
            objc_setAssociatedObject(self,
                                     recognizerAngle, newsAngle,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

