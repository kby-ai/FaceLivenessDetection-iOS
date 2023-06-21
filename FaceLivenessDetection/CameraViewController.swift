import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    static let LIVENESS_THRESHOLD = Float(0.7)
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var faceView: FaceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cameraView.translatesAutoresizingMaskIntoConstraints = true
        cameraView.frame = view.bounds
        
        faceView.translatesAutoresizingMaskIntoConstraints = true
        faceView.frame = view.bounds

        startCamera()
    }
    
    func startCamera() {
        let defaults = UserDefaults.standard
        let cameraLens_val = defaults.integer(forKey: "camera_lens")
        var cameraLens = AVCaptureDevice.Position.front
        if(cameraLens_val == 0) {
            cameraLens = AVCaptureDevice.Position.back
        }
        
        // Create an AVCaptureSession
        let session = AVCaptureSession()
        session.sessionPreset = .high

        // Create an AVCaptureDevice for the camera
        let device = AVCaptureDevice.default(for: .video)

        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraLens) else { return }
        guard let input = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        if session.canAddInput(input) {
            session.addInput(input)
        }

        // Create an AVCaptureVideoDataOutput
        let videoOutput = AVCaptureVideoDataOutput()

        // Set the video output's delegate and queue for processing video frames
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .default))

        // Add the video output to the session
        session.addOutput(videoOutput)

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        cameraView.layer.addSublayer(previewLayer)

        // Start the session
        session.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags.readOnly)
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let context = CIContext()
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        let image = UIImage(cgImage: cgImage!)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags.readOnly)

        // Rotate and flip the image
        var capturedImage = image.rotate(radians: .pi/2)
        let defaults = UserDefaults.standard
        let cameraLens_val = defaults.integer(forKey: "camera_lens")
        if(cameraLens_val == 1) {
            capturedImage = capturedImage.flipHorizontally()
        }

        let faceBoxes = FaceSDK.faceDetection(capturedImage)
        DispatchQueue.main.sync {
            self.faceView.setFrameSize(frameSize: capturedImage.size)
            self.faceView.setFaceBoxes(faceBoxes: faceBoxes)
        }
    }
    
    
    @IBAction func done_clicked(_ sender: Any) {
        if let vc = self.presentingViewController as? ViewController {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

