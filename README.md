# nguyen_ngoc_thang_nexlab

A new Flutter project.

## Pre-installation requirements
Make sure your device is installed with Flutter 

Connect to Simulator/Device:
If you don’t setup the simulator/device, please setup that like the link below:
- Set up iOS simulator: https://docs.flutter.dev/get-started/install/macos#set-up-the-ios-simulator
- Set up iOS physical device: https://docs.flutter.dev/get-started/install/macos#deploy-to-physical-ios-devices
- Set up Android Device: https://docs.flutter.dev/get-started/install/macos#set-up-your-android-device
- Set up Android emulator: https://docs.flutter.dev/get-started/install/macos#set-up-the-android-emulator

## Installation
Clean old build
```bash
  flutter clean
```

Get all dependencies
```bash
  flutter pub get
```

Install iOS pods
```bash
  cd iod/
  pod install
```

Generate models
```base
  dart run build_runner build -d
```

Run source code
```bash
  flutter run
```

## Project Structure 
```bash
/lib                                              (Main app)
/lib/app                                          (App level code)
/lib/app/blocs                                    (All common blocs. E.g: Connectivity)

/lib/data                                         (All data sources. E.g: Remote)
/lib/repository                                   (All repositories. E.g: Products)
/lib/models                                       (All models. E.g: Product)

/lib/features                                     (All features / screens)
/lib/features/[feature name]                      (Feature folder) (e.g: products)
/lib/features/[feature name]/bloc                 (Bloc of the feature)