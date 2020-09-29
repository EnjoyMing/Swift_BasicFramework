//
//  ImageView+E.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

fileprivate typealias imageClick = ((UIImageView)->())

extension UIImageView {
    @objc private func clickAction() {
        self.actionBlock?(self)
    }
    
    private struct RuntimeKey {
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
    }
    
    private var actionBlock: imageClick? {
        set {
            objc_setAssociatedObject(self,
                                     UIImageView.RuntimeKey.actionBlock!,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, UIImageView.RuntimeKey.actionBlock!) as? imageClick
        }
    }
    
    //MARK:====添加点击事件====
    @objc public func addAction(handle:@escaping ((UIImageView)->())) {
        self.actionBlock = handle
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickAction))
        self.addGestureRecognizer(tap)
    }
    
    @objc public func imgeUrl(_ imgUrl:String = "", _ placeholder:String = "") -> Void {
        var url:String = imgUrl
        if !url.hasPrefix("http") && url.count > 0 {
            url = hostUrl + "/" + url
        }
        self.kf.setImage(with: URL(string: url), placeholder: UIImage(named: placeholder), options: nil, progressBlock: nil) { (imge, error, CacheType, url) in
            printLog(error)
        }
    }
}
