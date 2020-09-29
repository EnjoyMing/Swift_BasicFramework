//
//  String+E.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var floatValue:Float{
        return (self as NSString).floatValue
    }
    var doubleValue:Double{
        return (self as NSString).doubleValue
    }
    var intValue:Int{
        return (self as NSString).integerValue
    }
    
    //TODO:==判断是否是URL地址==
    public func isURL() -> Bool {
        var result1 = false
        var result2 = false
        let urlRegex1 = "^https://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$"
        let urlTest1 = NSPredicate(format:"SELF MATCHES %@", urlRegex1)
        result1 = (urlTest1.evaluate(with:self))
        let urlRegex2 = "^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$"
        let urlTest2 = NSPredicate(format:"SELF MATCHES %@", urlRegex2)
        result2 = (urlTest2.evaluate(with:self))
        return result1 || result2
    }
    
    //TODO:==验证电话号码==
    public func isMobilePhone() -> Bool {
        var result = false
        let phoneRegex = "^((13[0-9])|(17[0-9])|(14[^4,\\D])|(15[^4,\\D])|(18[0-9]))\\d{8}$|^1(7[0-9])\\d{8}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        result = (phoneTest.evaluate(with:self))
        return result
    }
    
    //TODO:==验证邮箱格式==
    public func isEmail() -> Bool {
        if self.count == 0 {
            return false
        }
        let zipCodeNumber = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexCodeNumber = NSPredicate(format:"SELF MATCHES %@",zipCodeNumber)
        if regexCodeNumber.evaluate(with:self) {
            return true
        }
        return false
    }
    
    //TODO:==过滤掉所有换行、空格和Tab==
    public func removeAllSpaceAndNewline() -> String {
        var str = self.replacingOccurrences(of:" ", with:"")
        str = str.replacingOccurrences(of:" ", with:"")
        str = str.replacingOccurrences(of:"\r", with:"")
        str = str.replacingOccurrences(of:"\n", with:"")
        return str
    }
    
    //TODO:==把图片地址的空格替换为 20%==
    public func replaceSpaceWith20Percent() ->String{
        var str = self.replacingOccurrences(of:" ", with:"%20")
        str = str.replacingOccurrences(of:" ", with:"%20")
        return str
    }
    
    //TODO:==时间戳转时间==
    public func formatTimeWithRex(rex:String = "yyyy-MM-dd HH:mm") ->String{
        let string = NSString.init(string:self)
        let timeSta:TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = rex
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }

    //TODO:==将分变成元，保留两位小数==
    public func yuanMoneyString() ->String{
        let string = NSString.init(string:self)
        var newString = String(string)
        if string.length > 2 {
            newString = string.substring(to: string.length-2) + "." + string.substring(with:NSRange.init(location: string.length-2, length:2))
        }else if string.length == 2 {
            newString = "0." + String(string)
        }else if string.length == 1 {
            newString = "0.0" + String(string)
        }else{
            newString = "0.00"
        }
        return newString
    }

    //TODO:==获得整元==
    public func MoneyIntegerPart() ->String{
        let string = NSString.init(string:self)
        let fen = string.integerValue
        let newString = String(fen/100)
        return newString
    }
    
    //TODO:==将字典数组变成json 字符串==
    public func toJsonString(dics:Any) -> String {
        var dataStr = ""
        do{
            let data = try JSONSerialization.data(withJSONObject: dics, options: JSONSerialization.WritingOptions.prettyPrinted)
            dataStr  = String(describing:NSString.init(data: data, encoding:String.Encoding.utf8.rawValue)!)
        }catch{
            printLog("转换失败：\(error)")
        }
        return dataStr
    }

    //TODO:==将json字符串转dic==
    public func getJsonDic() -> Any? {
        var dic :Any!
        let jsonData = self.data(using:String.Encoding.utf8)
        if nil != jsonData {
            do{
                dic = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
            }catch{
                printLog("解析错误")
            }
        }
        return dic
    }
    
    /*根据字体和宽度计算文字高度
     - parameter width: 约束宽度
     - parameter font:  字体大小
     - returns: 高度
     */
    public func getStringHeight(width:CGFloat, font:UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height:CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [.font: font], context:nil)
        return boundingBox.height
    }

    //TODO:==打电话==
    public func callPhone() {
        let urlString = "tel://" + self
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success)in })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
