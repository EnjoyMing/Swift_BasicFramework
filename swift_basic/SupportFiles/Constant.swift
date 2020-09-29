//
//  Constant.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

//MARK: ========头文件==========
import Kingfisher
import SnapKit

//MARK: ========服务器==========
#if DEBUG
let hostUrl = "测试环境"
#else
let hostUrl = "线上环境"
#endif

public enum SaveKey {
    public static let isLogin = "isLogin"
    public static let FirstOpenApp = "FirstOpenApp"
}


//MARK: ========屏幕尺寸==========
let screen_w:CGFloat = UIScreen.main.bounds.width
let screen_h:CGFloat = UIScreen.main.bounds.height
let status_h:CGFloat = full_screen ? 44:20
let navbar_h:CGFloat = full_screen ? 88:64
let b_safe_h:CGFloat = full_screen ? 34:0
let tabbar_h:CGFloat = b_safe_h + 50
let na_tab_h:CGFloat = navbar_h + tabbar_h

//MARK: ========刘海屏判断==========
public var full_screen: Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}

//MARK: ========自定义打印日志==========
public func printLog<T>(_ message: T,
                        fileName: String = #file,
                        methodName: String = #function,
                        lineNumber: Int = #line) {
#if DEBUG
    //文件名、方法、行号、打印信息
    print("文件名: \((fileName as NSString).lastPathComponent) \n方法名: \(methodName)  \n行号数: \(lineNumber) \n打印内容: \(message)\n");
#endif
}

//MARK: ========16进制颜色==========
public func RGBX(_ hexValue: Int, a: CGFloat) -> (UIColor) {//16进制颜色
    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                   alpha: a)
}
public func RGBX0(_ hexValue: Int) -> (UIColor) {//16进制颜色
    return RGBX(hexValue, a: 1.0)
}

//MARK:============获取当前控制器==========
public func currentVC() -> UIViewController? {
    guard let window = UIApplication.shared.windows.first else {
        return nil
    }
    var tempView: UIView?
    for subview in window.subviews.reversed() {
        if subview.classForCoder.description() == "UILayoutContainerView" {
            tempView = subview
            break
        }
    }
    if tempView == nil {
        tempView = window.subviews.last
    }
    var nextResponder = tempView?.next
    var next: Bool {
        return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController
    }
    while next{
        tempView = tempView?.subviews.first
        if tempView == nil {
            return nil
        }
        nextResponder = tempView!.next
    }
    return nextResponder as? UIViewController
}
