//
//  ViewController.swift
//  GPUImage实时画面
//
//  Created by MrHuang on 17/8/14.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {

    // 1. 创建相机
    fileprivate lazy var cameraVideo : GPUImageVideoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .front)
    // 2. 创建曝光(美白)滤镜
    fileprivate lazy var brightnessFilter = GPUImageBrightnessFilter()
    
    @IBOutlet weak var imageView : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // 1.1 调整摄像头方向
        cameraVideo.outputImageOrientation = .portrait
        cameraVideo.delegate = self
        // 2.1 设置滤镜的参数 把滤镜添加到摄像头上
        brightnessFilter.brightness = 0.2
        
        cameraVideo.addTarget(brightnessFilter)
        
        // 3. 创建实时画面
        let preview = GPUImageView(frame: view.bounds)
        view.insertSubview(preview, at: 0)
        brightnessFilter.addTarget(preview)
        
        // 开始捕捉画面
        cameraVideo.startCapture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController : GPUImageVideoCameraDelegate {
    
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        print("正在实时画面采集！！！")
    }

}
