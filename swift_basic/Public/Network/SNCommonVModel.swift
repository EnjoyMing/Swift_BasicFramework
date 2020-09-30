//
//  SNCommonVModel.swift
//  swift_basic
//
//  Created by silence on 2020/9/30.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit

class SNCommonVModel: NSObject {

    //TODO:=========更新系统=========
    static func postSystemUpdate() -> Void {
        var param:[String:String] = [:]
        param["user_id"] = "user_id"
        param["os"] = "1"
        SNCommonProvider.request(.SystemUpdate(param)) {(result) in
            if case let .success(response) = result {
                let data = try?response.mapJSON()
                guard let resultDict = data as? [String:Any] else {
                    return
                }
                print(resultDict)
            }else if case let .failure(response) = result {
                print(response.errorUserInfo)
            }
        }
    }
}
