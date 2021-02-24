# telr_flutter

![pub package](https://img.shields.io/pub/v/location.svg)

## Getting Started

### Flutter setup
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  telr_flutter: ^0.0.1
```

### Android Setup

 You should add in your applications `<your-app>/android/app/src/main/AndroidManifest.xml`:

```xml
  <manifest 
    xmlns:tools="http://schemas.android.com/tools"
```

```xml
   <application
        tools:replace="android:label,name"
```

Add the following lines inside section ``android`` in your app module `build.gradle`:

```gradle
  packagingOptions {
       exclude 'META-INF/license.txt'
       exclude 'META-INF/notice.txt'
    }
```

### iOS Setup
Add the following line inside your ios `Podfile` file:
```ruby
  platform :ios, '12.4'
```

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
    end
  end
end
```
then in `Terminal` run this commands:
```
$ cd ios
$ pod update
```

## Usage

Then you just have to import the package with

```dart
  import 'package:telr_flutter/telr_flutter.dart';
```
Then in your code 
```dart
   var telr = TelrFlutter(
      configuration: TelrConfiguration(
        key: "pQ6nP-7rHt@5WRFv",   // KEY FROM TELR DASHBOARD
        storeId: "15996",          // STORE ID FROM TELR DASHBOARD
        email: "mail@gmail.com",   // ACCOUNT MAIL
        enableSecurity: false,     // CHECK IF DEVICE IS ROOTED TO CAN COMPLETE THE PROCESS OR NOT
        testMode: true,            // FOR TESTING PREDEFINDED CARDS IN YOUR ACCOUNT ONLY AND DON'T ACCEPT ANY REAL CARD 
      ),
    );
    
    telr.billingAddress = BillingAddress(
      city: "Dubai",
      country: "AE",
      firstName: "Basem",
      lastName: "Abduallah",
      line: "236b stree",
      phoneNumber: "123456789",
      region: "Dubai",
    );
    
    telr.makePayment(
      transaction: Transaction(
        amount: "2",
        currency: "AED",
        language: "en",     // (OPTIONAL)
        userId: "123455",   // USER ID FROM YOUR SYSTEM (OPTIONAL)
      ),
    );
```

## Feedback

Please feel free to [give me any feedback](https://github.com/BisoDevil/TelrFlutter/issues)
helping support this plugin !


# License

Copyright (c) 2021 by Bassem Abduallah. Some rights reserved.

`telr_flutter` is under the terms of the **MIT License**, following all clarifications stated in the [license file](license.md).