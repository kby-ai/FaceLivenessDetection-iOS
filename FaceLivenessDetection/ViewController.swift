import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
            
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraBtnView: UIView!
    @IBOutlet weak var imageBtnView: UIView!
    @IBOutlet weak var settingsBtnView: UIView!
    @IBOutlet weak var aboutBtnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var ret = FaceSDK.setActivation("glF/068/SCjGIKN/o1HwZKKEANRWrO0eCTY7VinO46mMiXWcccNfCGLzAe2aNU2JBbjcn+IY000Q" +
                                        "zwYQUjEqx8X4Dkx41KMcZhJQSSdPg9KBEpxbOaksjsPCktAy78wlUJ9L+zmX6oa0h/3H45gMCHka" +
                                        "qPjjEWqrtGotonspHOxo5Z8TqofHSWJ04ORGllILdB4UQELaeToomCJMSNMJRKt425sIEdidO/+2" +
                                        "cQTdw04ShTpyMRgFI4B/sY5XMlz8Jyh1L9X3Yf5vEzj/Dk6d/7mtp1r3vRzIaBiFvk8M0Y0CyIwK" +
                                        "pdXxtkmC/OAO7DqzT3XQL69oX51XBMIwQXFriA==")
        
        if(ret == SDK_SUCCESS.rawValue) {
            ret = FaceSDK.initSDK()
        }
        
        if(ret != SDK_SUCCESS.rawValue) {
            warningLbl.isHidden = false
            
            if(ret == SDK_LICENSE_KEY_ERROR.rawValue) {
                warningLbl.text = "Invalid license!"
            } else if(ret == SDK_LICENSE_APPID_ERROR.rawValue) {
                warningLbl.text = "Invalid license!"
            } else if(ret == SDK_LICENSE_EXPIRED.rawValue) {
                warningLbl.text = "License expired!"
            } else if(ret == SDK_NO_ACTIVATED.rawValue) {
                warningLbl.text = "No activated!"
            } else if(ret == SDK_INIT_ERROR.rawValue) {
                warningLbl.text = "Init error!"
            }
        }
        
        SettingsViewController.setDefaultSettings()
    }
    
    @IBAction func camera_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.cameraBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    @IBAction func camera_touch_cancel(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.cameraBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func camera_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.cameraBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }

        performSegue(withIdentifier: "camera", sender: self)
    }
    
    
    @IBAction func image_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.imageBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    @IBAction func image_touch_up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.imageBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func image_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.imageBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
 
    
    @IBAction func settings_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.settingsBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    
    @IBAction func settings_touch_up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.settingsBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func settings_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.settingsBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }

        performSegue(withIdentifier: "settings", sender: self)
    }
    
    @IBAction func about_touch_down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.aboutBtnView.backgroundColor = UIColor(named: "clr_main_button_bg2") // Change to desired color
        }
    }
    
    
    @IBAction func about_touch_up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.aboutBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }
    }
    
    @IBAction func about_clicked(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.aboutBtnView.backgroundColor = UIColor(named: "clr_main_button_bg1") // Change to desired color
        }

        performSegue(withIdentifier: "about", sender: self)
    }
    
    @IBAction func brand_clicked(_ sender: Any) {
        let webURL = URL(string: "https://kby-ai.com")
        UIApplication.shared.open(webURL!, options: [:], completionHandler: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        dismiss(animated: true, completion: nil)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }

        let fixed_image = image.fixOrientation()
        imageView.image = fixed_image
        
        let faceBoxes = FaceSDK.faceDetection(fixed_image)
        if(faceBoxes.count == 0) {
            resultLbl.text = "No face"
            resultLbl.textColor = UIColor.red
            return
        }
        
        
        let defaults = UserDefaults.standard
        let livenessThreshold = defaults.float(forKey: "liveness_threshold")
        
        let faceBox = faceBoxes[0] as! FaceBox
        if(faceBox.liveness < livenessThreshold) {
            resultLbl.text = "SPOOF, Score: " + String(format: "%.3f", faceBox.liveness)
            resultLbl.textColor = UIColor.red
        } else {
            resultLbl.text = "REAL, Score: " + String(format: "%.3f", faceBox.liveness)
            resultLbl.textColor = UIColor.green
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

