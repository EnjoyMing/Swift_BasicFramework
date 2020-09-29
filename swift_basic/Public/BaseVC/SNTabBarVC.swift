//
//  SNTabBarVC.swift
//  swift_basic
//
//  Created by silence on 2020/9/29.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit

class SNTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAppearance()
        self.setupViewControllers()
    }
}
extension SNTabBarVC {
    private func setupViewControllers(){
        //生成文件的存储路径
        let plistPath = Bundle.main.path(forResource: "TabBarItems", ofType: "plist")
        //读取属性列表文件，并转化为可变字典对象
        let data:NSArray = NSArray.init(contentsOfFile: plistPath!)!
        
        //根据字符串获取对应的class，在Swift中不能直接使用
        //Swift中命名空间的概念
        guard let nameSpage = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return
        }
        var i = 0
        for dict in data {
            let modelDict:Dictionary = dict as! Dictionary<String, Any>
            let vcName:String = modelDict["className"] as! String
            let normallImg:String = modelDict["normalImg"] as! String
            let selectedImg:String = modelDict["selectedImg"] as! String
            var titleS:String = modelDict["titleName"] as! String
            guard let childVcClass = NSClassFromString(nameSpage + "." + vcName) else {
                print("没有获取到对应的class")
                return
            }
            guard let childVcType = childVcClass as? SNBaseVC.Type else {
                print("没有得到的类型")
                return
            }
            if i == 2 {
                titleS = ""
            }
            //根据类型创建对应的对象
            let vc = childVcType.init()
            vc.tabBarItem.title = titleS
            vc.tabBarItem.image = UIImage(named: normallImg)?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage = UIImage(named: selectedImg)?.withRenderingMode(.alwaysOriginal)
            self.addChild(SNNavigationVC(rootViewController: vc))
            i = i + 1
        }
    }
       
    private func setupAppearance(){
        self.view.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        let tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .normal)
        tabBar.setTitleTextAttributes([.foregroundColor : UIColor.red], for: .highlighted)
        tabBar.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 12)], for: .normal)
//        self.tabBar.barTintColor = UIColor(red: 247/255, green: 1.0, blue: 1.0, alpha: 1.0)
    }

}
