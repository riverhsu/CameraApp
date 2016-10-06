//
//  ViewController.swift
//  CameraApp
//
//  Created by Sgmedical on 2016/10/6.
//  Copyright © 2016年 Sgmedical. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImaged: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraBtnAction(_ sender: UIButton) {
        // mainly on UIImagePickerControllerDelegate 
        // steps:
        // 1. 確認 camera 是不是可用狀態
        // 2. 設定 imagePicker 物件是 UIImagePickerController(影像控制物件)
        // 3. 將 UIImagePickerController delegate 給自己作管理 （即UIVIEW 就是 server 角色)
        // 4. 將 imagePicker 資料源指定為 camera
        // 5. 其他設定
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;  //為什麼要加 ";" ？
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
    }

    @IBAction func photoGalleryAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        // UIImageJPEGRepresentation(<#T##image: UIImage##UIImage#>, <#T##compressionQuality: CGFloat##CGFloat#>)
        let imageData = UIImageJPEGRepresentation(pickedImaged.image!, 0.6)
        let compressedJPEGImage = UIImage(data:imageData!)
        /*
        UIImageWriteToSavedPhotosAlbum(<#T##image: UIImage##UIImage#>, <#T##completionTarget: Any?##Any?#>, <#T##completionSelector: Selector?##Selector?#>, <#T##contextInfo: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
        */
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        
    }
    
    //以下的 function 不在自動提示，是手動寫.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject: AnyObject]) {
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            pickedImaged.contentMode = .scaleAspectFit
            pickedImaged.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    */
    
    func saveNotice(){
        let alertController = UIAlertController(title: "Image saved", message: "Your picture was successfully save", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

