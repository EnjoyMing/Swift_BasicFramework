//
//  SNCommonApi.swift
//  swift_basic
//
//  Created by silence on 2020/9/30.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import Moya

let SNCommonProvider = MoyaProvider<SNCommonApiServer>()

//请求分类
public enum SNCommonApiServer {
    case SystemUpdate(Dictionary<String, Any>)  //是否更新系统
}
//请求配置
extension SNCommonApiServer: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: hostUrl)!
    }
     
    //各个请求的具体路径
    public var path: String {
        var urlPath = ""
        switch self {
        case .SystemUpdate(_):
            urlPath = "/Version/getVersionInfo_mobile.action"
            break
        }
        printLog("请求地址：\(hostUrl + urlPath)")
        return urlPath
    }
     
    //请求类型
    public var method: Moya.Method {
        return .post
    }
     
    //请求任务事件（这里附带上参数）
    public var task: Task {
        var paramDict:[String: Any] = [:]
        switch self {
        case .SystemUpdate(let param):
            paramDict = param
            break
        }
        printLog("请求参数：\(paramDict)")
        return .requestParameters(parameters: paramDict,encoding: URLEncoding.default)
    }
     
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
     
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
     
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}
