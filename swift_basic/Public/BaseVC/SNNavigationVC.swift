//
//  SNNavigationVC.swift
//  swift_basic
//
//  Created by silence on 2020/9/29.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit

class SNNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        if NSObject.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
        self.view.backgroundColor = .white
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named: "kf_hx_whrite_back_img"), for: .normal)
            btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            btn.imageEdgeInsets = UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 32)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    @objc private func backClick(){
        popViewController(animated: true)
    }

}
extension SNNavigationVC:UIGestureRecognizerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.navigationController?.viewControllers.count == 1 {
            return false
        }
        return true
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController .responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
        if navigationController.viewControllers.count == 1 {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
            navigationController.interactivePopGestureRecognizer?.delegate = nil
        }
    }
}

