//
//  SNBaseVC.swift
//  swift_basic
//
//  Created by silence on 2020/9/29.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit

class SNBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:RGBX0(0x333333)]
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vcArray:Array<Bool> = [self.isKind(of: SNHomePageVC.self)]
        if vcArray.contains(true){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
            return
        }
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    deinit {
        let str:String = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? "NoClass"
        printLog(">>>>>>> 释放---\(str) <<<<<<<<<")
    }
    
    public lazy var dataArray:Array<Any> = []
    
    public lazy var tableView:UITableView = {
        let temp = UITableView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: screen_w,
                                             height: screen_h-navbar_h),
                               style: .grouped)
        temp.delegate = self
        temp.dataSource = self
        temp.separatorStyle = .none
        temp.backgroundColor = .white
        temp.showsVerticalScrollIndicator = false
        temp.showsHorizontalScrollIndicator = false
        temp.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 0.0001))
        temp.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 0.0001))
        return temp
    }()
                      
}
//MARK:==========TableView代理==========
extension SNBaseVC:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 0.0001))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: screen_w, height: 0.0001))
    }
}
 
