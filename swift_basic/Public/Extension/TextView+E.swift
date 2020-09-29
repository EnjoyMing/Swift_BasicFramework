//
//  TextView+E.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

fileprivate typealias TextViewChange = ((UITextView)->())

extension UITextView {
    @objc private func changeAction() {
        self.actionBlock?(self)
    }
    
    private struct RuntimeKey {
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
    }
    private var actionBlock: TextViewChange? {
        set {
            objc_setAssociatedObject(self,
                                     UITextView.RuntimeKey.actionBlock!,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, UITextView.RuntimeKey.actionBlock!) as? TextViewChange
        }
    }
    
    @objc public func textChangeAction(handle:@escaping ((UITextView)->())) {
        self.actionBlock = handle
        self.target(forAction: #selector(changeAction), withSender: UIControl.Event.editingChanged)
    }
    
    @objc class func componentStr(range:NSRange, textStr:String?, string:String) -> String {
        if range.length == 0 { //输入
            let muStr:NSMutableString = NSMutableString.init(string: textStr!)
            muStr.insert(string, at: range.location)
            return String.init(muStr)
        }else {//删除
            let muStr:NSMutableString = NSMutableString.init(string: textStr!)
            muStr.deleteCharacters(in: range)
            muStr.insert(string, at: range.location)
            return String.init(muStr)
        }
        
    }
}
