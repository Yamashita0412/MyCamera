//
//  ViewController.swift
//  MyCamera
//
//  Created by 山下京之介 on 2018/08/15.
//  Copyright © 2018年 山下京之介. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var pictureimage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("カメラは利用できます")
            
            // UIImagePickerControllerインスタンス作成
            let imagePickerController = UIImagePickerController()
            // sourceTypeにCameraを設定
            imagePickerController.sourceType = .camera
            // delegate設置
            imagePickerController.delegate = self
            // モーダルビューで表示
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラは利用できません。")
        }
    }
    
    @IBAction func SNSButtonAction(_ sender: Any) {
    
    }
    
    // 撮影終了後に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 撮影した写真を配置したpictureImageに渡す
        pictureimage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
}

