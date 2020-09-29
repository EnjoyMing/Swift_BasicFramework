//
//  Image+E.swift
//  swift_basic
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    //MARK:=====16进制颜色生成图片=====
    public class func createImage(_ hexValue: Int, _ size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let co = RGBX0(hexValue)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(co.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image ?? UIImage()
    }
    //MARK:=====颜色生成图片=====
    public class func createImage(_ color: UIColor, _ size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image ?? UIImage()
    }
    
    //MARK:=====对指定图片进行拉伸=====
    public func resizableImage(name: String) -> UIImage {
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsets(top: imageHeight, left: imageWidth, bottom: imageHeight, right: imageWidth))
        return normal
    }
    
    /* 压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    public func compressImage(image: UIImage, maxLength: Int) -> Data? {
        let newSize = self.scaleImage(image: image, imageLength: 300)
        let newImage = self.resizeImage(image: image, newSize: newSize)
        var compress:CGFloat = 0.9
        var data = newImage.jpegData(compressionQuality: compress)
        
        while data?.count ?? 0 > maxLength && compress > 0.01 {
            compress -= 0.02
            data = newImage.jpegData(compressionQuality: compress)
        }
        return data
    }
    
    /*  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    public func scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        if (width > imageLength || height > imageLength){
            if (width > height) {
                newWidth = imageLength;
                newHeight = newWidth * height / width;
            }else if(height > width){
                newHeight = imageLength;
                newWidth = newHeight * width / height;
            }else{
                newWidth = imageLength;
                newHeight = imageLength;
            }
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /* 获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    public func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }

}
