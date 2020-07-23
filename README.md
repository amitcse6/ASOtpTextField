# ASOtpTextField

[![CI Status](https://img.shields.io/travis/amitpstu1@gmail.com/ASOtpTextField.svg?style=flat)](https://travis-ci.org/amitpstu1@gmail.com/ASOtpTextField)
[![Version](https://img.shields.io/cocoapods/v/ASOtpTextField.svg?style=flat)](https://cocoapods.org/pods/ASOtpTextField)
[![License](https://img.shields.io/cocoapods/l/ASOtpTextField.svg?style=flat)](https://cocoapods.org/pods/ASOtpTextField)
[![Platform](https://img.shields.io/cocoapods/p/ASOtpTextField.svg?style=flat)](https://cocoapods.org/pods/ASOtpTextField)

Screenshots
---------
![ASOtpTextField Screenshots](asotptextfield_screenshot.gif)

## Example

```swift
import ASOtpTextField

class ViewController: UIViewController {
    
    @IBOutlet weak var otpField: ASOtpTextFieldViewClassic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpField
            .setField(6)
            .setInputBoxStyle(.box)
    }
    
    @IBAction func submitEventHandler(_ sender: Any) {
        let otpArray = otpField?.getTextArray()
        let otp = otpArray?.joined(separator: "")
        print("otp: \(otp ?? "")")
    }
}


```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ASOtpTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ASOtpTextField'
```

## Author

amitpstu1@gmail.com, amitpstu1@gmail.com

## License

ASOtpTextField is available under the MIT license. See the LICENSE file for more info.
