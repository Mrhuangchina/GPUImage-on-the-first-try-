//
//  ViewController.swift
//  GPUImage美颜相机
//
//  Created by MrHuang on 17/8/14.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {
    // 1.创建美颜相机
    fileprivate lazy var camera : GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
    // 2.曝光(美白)滤镜
    fileprivate lazy var brightnessFilter = GPUImageBrightnessFilter()
    
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 1.1 相机的方向
        camera.outputImageOrientation = .portrait
    
        // 2.1 设置曝光的参数
        brightnessFilter.brightness = 0.5
        camera.addTarget(brightnessFilter)
        
        // 3. 创建一个GPUImageView 显示实时画面
        let preview = GPUImageView(frame: view.bounds)
        view.insertSubview(preview, at: 0)
        brightnessFilter.addTarget(preview)
        
        // 4. 开始捕捉画面
        camera.startCapture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePhoto(){
    camera.capturePhotoAsImageProcessedUp(toFilter: brightnessFilter) { (image, error) in
        UIImageWriteToSavedPhotosAlbum(image!, nil,nil ,nil)
        self.imageView.image = image
        self.camera.stopCapture()
        
        }
    }

}

