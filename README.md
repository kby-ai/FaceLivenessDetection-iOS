<p align="center">
  <a href="https://play.google.com/store/apps/dev?id=7086930298279250852" target="_blank">
    <img alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/125717930/246971879-8ce757c3-90dc-438d-807f-3f3d29ddc064.png" width=500/>
  </a>  
</p>

👏 Product List

https://github.com/kby-ai/Product

👏  We have published the Face Liveness Detection, Face Recognition SDK and ID Card Recognition SDK for the server.

  - [FaceLivenessDetection-Docker](https://github.com/kby-ai/FaceLivenessDetection-Docker)

  - [FaceRecognition-Docker](https://github.com/kby-ai/FaceRecognition-Docker)

  - [IDCardRecognition-Docker](https://github.com/kby-ai/IDCardRecognition-Docker)

# FaceLivenessDetection-iOS

## Overview
The demo project showcases real-time Face Liveness Detection technology.

> The demo is integrated with KBY-AI's Basic Face Mobile SDK.

  | Basic      | Standard | Premium |
  |------------------|------------------|------------------|
  | Face Detection        | Face Detection    | Face Detection |
  | Face Liveness Detection        | Face Liveness Detection    | Face Liveness Detection |
  | Pose Estimation        | Pose Estimation    | Pose Estimation |
  |         | Face Recognition    | Face Recognition |
  |         |         | 68 points Face Landmark Detection |
  |         |         | Face Quality Calculation |
  |         |         | Face Occlusion Detection |
  |         |         | Eye Closure Detection |
  |         |         | Age, Gender Estimation |

> For other solutions, please explore the following:
> 
> [Face Liveness Detection - Android(Basic SDK)](https://github.com/kby-ai/FaceLivenessDetection-Android)
> 
> [Face Liveness Detection - iOS(Basic SDK)](https://github.com/kby-ai/FaceLivenessDetection-iOS)
> 
> [Face Recognition - Android(Standard SDK)](https://github.com/kby-ai/FaceRecognition-Android)
> 
> [Face Recognition - iOS(Standard SDK)](https://github.com/kby-ai/FaceRecognition-iOS)
> 
> [Face Recognition - Flutter(Standard SDK)](https://github.com/kby-ai/FaceRecognition-Flutter)
> 
> [Face Attribute - Android(Premium SDK)](https://github.com/kby-ai/FaceAttribute-Android)
> 
> [Face Attribute - iOS(Premium SDK)](https://github.com/kby-ai/FaceAttribute-iOS)

## Download on the App Store

<a href="https://apps.apple.com/us/app/face-liveness-detection/id6448392118" target="_blank">
  <img alt="" src="https://user-images.githubusercontent.com/125717930/235276083-d20fe057-214d-497c-a431-4569bbeed2fe.png" height=80/>
</a>

## Screenshots

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/231923322-d675622c-972c-4a10-9a7a-e94607dbf5bb.png" width=300/>
  <img src="https://github.com/kby-ai/FaceLivenessDetection-iOS/assets/125717930/1c28d837-67be-4e6a-b408-01ae8d847fd0" width=300/>
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/231923346-9ff7015a-9c68-4984-b7b0-0beb7f7387f4.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/231923352-f9403d52-69e5-4f5d-b5ee-0e48ede8ec6f.png" width=300/>
</p>

## SDK License

This project uses kby-ai's liveness detection SDK. The SDK requires a license per bundle ID.

- The code below shows how to use the license: https://github.com/kby-ai/FaceLivenessDetection-iOS/blob/ff6722b7946797f0c9f2314f88eb43a96ac59f57/FaceLivenessDetection/ViewController.swift#L18-L27

- To request a license, please contact us:
```
Email: contact@kby-ai.com

Telegram: @kbyai

WhatsApp: +19092802609

Skype: live:.cid.66e2522354b1049b
```

## About SDK

### Set up
1. Copy the SDK (facesdk.framework folder) to the root folder of your project.

2. Add SDK framework to the project in xcode

> Project Navigator -> General -> Frameworks, Libraries, and Embedded Content

![image](https://user-images.githubusercontent.com/125717930/231925359-ef30b3c0-d2d9-4b32-ae57-80b42b021b91.png)

3. Add the bridging header to your project settings

> Project Navigator -> Build Settings -> Swift Compiler - General

![image](https://user-images.githubusercontent.com/125717930/231926873-6a510b63-209a-480f-8486-ec11b1962613.png)


### Initializing an SDK

- Step One

To begin, you need to activate the SDK using the license that you have received.
```
FaceSDK.setActivation("...") 
```

If activation is successful, the return value will be SDK_SUCCESS. Otherwise, an error value will be returned.

- Step Two

After activation, call the SDK's initialization function.
```
FaceSDK.initSDK()
```
If initialization is successful, the return value will be SDK_SUCCESS. Otherwise, an error value will be returned.

### Face Detection and Liveness Detection

The FaceSDK offers a single function for detecting face and liveness detection, which can be used as follows:
```
let faceBoxes = FaceSDK.faceDetection(image)
```

https://github.com/kby-ai/FaceLivenessDetection-iOS/blob/ff6722b7946797f0c9f2314f88eb43a96ac59f57/FaceLivenessDetection/CameraViewController.swift#L62-L78

This function takes a single parameter, which is a UIImage object. 
The return value of the function is a list of FaceBox objects. 
Each FaceBox object contains the detected face rectangle, liveness score, and facial angles such as yaw, roll, and pitch.

