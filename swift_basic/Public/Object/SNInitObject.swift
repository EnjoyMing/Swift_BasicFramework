//
//  SNInitObject.swift
//  swift_basic
//
//  Created by silence on 2020/9/29.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SNInitObject: NSObject {
    
    @objc public static let share = SNInitObject()
    private override init() {}
    
    //TODO:展示引导页或者启动图
    @objc public func showGuideViewOrLaunchView() {
        self.init_custom()
        let status:Bool = UserDefaults.standard.value(forKey: SaveKey.FirstOpenApp) as? Bool ?? false
        if !status {
            SNGuideView.showGuideView()
        }else{
            self.setupLaunchImage()
        }
    }
    
    //TODO:初始化根视图
    @objc public func setRootVC() -> Void {
        var window:UIWindow!
        if #available(iOS 13, *) {
            window = UIApplication.shared.windows.first
        }else{
            window = UIApplication.shared.keyWindow
        }
        let status:Bool = UserDefaults.standard.value(forKey: SaveKey.isLogin) as? Bool ?? false
        if status {
            window.rootViewController = SNTabBarVC()
        }else{
            window.rootViewController = SNNavigationVC(rootViewController: SNLoginVC())
        }
    }
    
    //TODO:====初始化裤====
    fileprivate func init_custom() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    //TODO:初始化动态启动图
    fileprivate func setupLaunchImage() {
        let window = UIApplication.shared.windows.first
        let launchSB = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "launchScreen")
        let launchView = launchSB.view
        window?.addSubview(launchView!)
        // 动画效果
        UIView.animate(withDuration: 1.5, animations: {
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
        }) {[weak self] (success) in
            self?.setRootVC()
            launchView?.removeFromSuperview()
        }
    }
}
