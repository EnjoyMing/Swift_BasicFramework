//
//  Buttion+E.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

fileprivate typealias buttonClick = ((UIButton)->())

extension UIButton {
    @objc private func clickAction() {
        self.actionBlock?(self)
    }
    
    private struct RuntimeKey {
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
    }
    
    private var actionBlock: buttonClick? {
        set {
            objc_setAssociatedObject(self, UIButton.RuntimeKey.actionBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, UIButton.RuntimeKey.actionBlock!) as? buttonClick
        }
    }
    
    //MARK:====添加点击事件====
    @objc public func addAction(controlEvents: UIControl.Event = .touchUpInside ,handle:@escaping ((UIButton)->())) {
        self.actionBlock = handle
        self.addTarget(self, action: #selector(clickAction), for: controlEvents)
    }
    
    //MARK:====设置网络图片====
    @objc public func imge(_ imgUrl:String = "") -> Void {
        var url:String = imgUrl
        if !url.hasPrefix("http") && url.count > 0 {
            url = hostUrl + "/" + url
        }
        self.kf.setImage(with: URL(string: url), for: .normal)
    }
}
