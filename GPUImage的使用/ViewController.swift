//
//  ViewController.swift
//  GPUImage-Use
//
//  Created by MrHuang on 17/8/14.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit
import GPUImage


class ViewController: UIViewController {
   
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let imagetest = UIImage(named: "test1")
       
        // 2.使用GPUImage高斯模糊效果
        // 2.1 如果是对图像进行处理GPUImagePicture
        let imgePicture = GPUImagePicture(image: imagetest)
        
        // 2.2 使用高斯模糊滤镜
        let GaussianFilter  = GPUImageGaussianBlurFilter()
        
        // 2.3  设置纹理 并将滤镜添加到imagePicture
        //纹理
        GaussianFilter.blurRadiusInPixels = 2
        GaussianFilter.texelSpacingMultiplier = 2
        
        imgePicture?.addTarget(GaussianFilter)
        
        // 3.处理图片
        GaussianFilter.useNextFrameForImageCapture()
        imgePicture?.processImage()
       
        let newImage = GaussianFilter.imageFromCurrentFramebuffer()
        
        imageview.image = newImage
    }

}

