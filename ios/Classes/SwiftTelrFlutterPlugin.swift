import Flutter
import UIKit
import TelrSDK
public class SwiftTelrFlutterPlugin: NSObject, FlutterPlugin {
    static var result :FlutterResult?
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "telr_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftTelrFlutterPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startTransaction":
            let  paymentRequest = preparePaymentRequest(call: call)
            let telrController = TelrController()
            let nav = UINavigationController(rootViewController: telrController)
            telrController.delegate = self
            nav.modalPresentationStyle = .fullScreen
            telrController.paymentRequest = paymentRequest
            
            let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            
            window.rootViewController?.present(nav, animated: true)
            SwiftTelrFlutterPlugin.result = result
            
            
            break
        default:
            result(false)
        }
        
        
    }
    private func preparePaymentRequest(call:FlutterMethodCall) -> PaymentRequest{
        let args = call.arguments as! [String:Any]
        let config = args["config"] as! [String:Any]
        let billingAddress = args["billingAddress"] as! [String:String]
        let transaction = args["transaction"] as! [String:String]
        print(args)
        let paymentReq = PaymentRequest()
        
        paymentReq.key = config["key"] as! String
        
        paymentReq.store = config["storeId"] as! String
        
        paymentReq.appId = "123456789"
        
        paymentReq.appName = "TelrSDK"
        
        paymentReq.appUser = "123456"
        
        paymentReq.appVersion = "0.0.1"
        
        paymentReq.transTest = config["testMode"] as! Bool ? "1":"0"
        
        paymentReq.transType = "auth"
        
        paymentReq.transClass = "paypage"
        
        paymentReq.transCartid = String(arc4random())
        
        paymentReq.transDesc = "Payment"
        
        paymentReq.transCurrency = transaction["currency"]!
        
        paymentReq.transAmount = transaction["amount"]!
        
        paymentReq.billingEmail = config["email"] as! String
        
        paymentReq.billingFName = billingAddress["firstName"]!
        
        paymentReq.billingLName = billingAddress["lastName"]!
        
        paymentReq.billingTitle = "Mr"
        
        paymentReq.city = billingAddress["city"]!
        
        
        
        paymentReq.country = billingAddress["country"]!.localizedCapitalized
        
        paymentReq.region = billingAddress["region"]!
        
        paymentReq.address = billingAddress["line"]!
        
        paymentReq.language = "en"
        
        return paymentReq
        
    }
    
}
extension SwiftTelrFlutterPlugin:TelrControllerDelegate{
    public func didPaymentCancel() {
        print("Cancel button")
        SwiftTelrFlutterPlugin.result?(false)
    }
    
    public func didPaymentSuccess(response: TelrResponseModel) {
        print("Success")
        SwiftTelrFlutterPlugin.result?(true)
    }
    
    public func didPaymentFail() {
        print("Fail")
        SwiftTelrFlutterPlugin.result?(false)
    }
    
    
    
    
}
