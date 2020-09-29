//
//  SNLoginVC.swift
//  swift_basic
//
//  Created by silence on 2020/9/29.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit

class SNLoginVC: SNBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: SaveKey.isLogin)
        UserDefaults.standard.synchronize()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
