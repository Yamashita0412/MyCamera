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
        
        // カメラかフォトライブラリーどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
//        // カメラを起動するための選択肢を定義
//        let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: nil)
//        alertController.addAction(cameraAction)
//
//        // フォトライブラリーを起動するための選択肢を定義
//        let photoAction = UIAlertAction(title: "フォトギャラリー", style: .default, handler: nil)
//        alertController.addAction(photoAction)
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラが起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
                // カメラ起動
                let imagePickerController : UIImagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate   = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        // フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリーをが起動するための選択肢を定義
            let photoAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action:UIAlertAction) in
                //フォトライブラリーを起動
                let imagePickerController : UIImagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoAction)

        }
        
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        // iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        // 選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SNSButtonAction(_ sender: Any) {
        
        // 表示画像をアンラップしてシェア画像として取り出し
        if let shareImage = pictureimage.image {
            // UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            
            // UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            
            // iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            
            // UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
            
        }
    }
    
    // 撮影終了後に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        // 撮影した写真を配置したpictureImageに渡す
//        pictureimage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        // モーダルビューを閉じる
//        dismiss(animated: true, completion: nil)
        captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    
    // 次の画面遷移するときにわやす画像を格納する場所
    var captureImage : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面インスタンスを格納
        if let nextViewController = segue.destination as? EffectViewController {
            // 次の画面のインスタンスに取得した画像を渡す
            nextViewController.originalImage = captureImage
        }
    }
}

