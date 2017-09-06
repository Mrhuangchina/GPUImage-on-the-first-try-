//
//  ViewController.swift
//  GPUImage-Other
//
//  Created by MrHuang on 17/8/14.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    fileprivate lazy var image = UIImage(named:"test1")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 褐色/怀旧
    @IBAction func brownness() {
        
        let brownness = GPUImageSepiaFilter()
      imageView.image = processImage(brownness)
        
    }
    //卡通
    @IBAction func cartoon() {
        
      let cartoon = GPUImageToonFilter()
      imageView.image = processImage(cartoon)
        
    }
    //素描
    @IBAction func sketch() {
        
      let sketch = GPUImageSketchFilter()
      imageView.image = processImage(sketch)
    }
    //浮雕
    @IBAction func emboss() {
       let emboss = GPUImageEmbossFilter()
       imageView.image = processImage(emboss)
        
    }

    private func processImage(_ filter : GPUImageFilter) -> UIImage?{
        // 对图片进行处理的Picture
        let processImage = GPUImagePicture(image: image)
    
        // 需要处理的滤镜
        processImage?.addTarget(filter)
    
        // 处理图片
        filter.useNextFrameForImageCapture()
        processImage?.processImage()
        
        // 取出最新的图片
        return filter.imageFromCurrentFramebuffer()
    }

}

