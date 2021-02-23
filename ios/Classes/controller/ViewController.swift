//
//  ViewController.swift
//  Pods
//
//  Created by Basem Abduallah on 23/02/2021.
//

import UIKit

import TelrSDK
class ViewController: UIViewController {
    
    
    
    var completionHandler: ((Bool)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor.white.cgColor
        requestPayment()
        // Do any additional setup after loading the view.
        
    }
    
    
    func  requestPayment(){
        
        
        let  paymentRequest = preparePaymentRequest()
        let telrController = TelrController()
        telrController.delegate = self
        
        telrController.paymentRequest = paymentRequest
        
        present(telrController, animated: false)
//        self.navigationController?.pushViewController(telrController, animated: true)
        
    }
    
    
    //
    private func preparePaymentRequest() -> PaymentRequest{
        
        
        let paymentReq = PaymentRequest()
        
        paymentReq.key = "BwxtF~dq9L#xgWZb"
        
        paymentReq.store = "21941"
        
        paymentReq.appId = "123456789"
        
        paymentReq.appName = "TelrSDK"
        
        paymentReq.appUser = "123456"
        
        paymentReq.appVersion = "0.0.1"
        
        paymentReq.transTest = "1"
        
        paymentReq.transType = "auth"
        
        paymentReq.transClass = "paypage"
        
        paymentReq.transCartid = String(arc4random())
        
        paymentReq.transDesc = "Test API"
        
        paymentReq.transCurrency = "AED"
        
        paymentReq.transAmount = "1"
        
        paymentReq.billingEmail = "girish.spryox@gmail.com"
        
        paymentReq.billingFName = "Hany"
        
        paymentReq.billingLName = "Sakr"
        
        paymentReq.billingTitle = "Mr"
        
        paymentReq.city = "Dubai"
        
        paymentReq.country = "AE"
        
        paymentReq.region = "Dubai"
        
        paymentReq.address = "line 1"
        
        paymentReq.language = "en"
        
        return paymentReq
        
    }
    
    
    
}
extension ViewController:TelrControllerDelegate{
    //Mark:- This method call when user click on back button
    func didPaymentCancel() {
        
        self.navigationController?.popToRootViewController(animated: false)
        print("Basem didPaymentCancel")      
        
    }
    
    //Mark:- This method call when payment done successfully
    func didPaymentSuccess(response: TelrResponseModel) {
        
        print("didPaymentSuccess")
        
        print("Trace \(String(describing: response.trace))")
        
        print("Status \(String(describing: response.status))")
        
        print("Avs \(String(describing: response.avs))")
        
        print("Code \(String(describing: response.code))")
        
        print("Ca_valid \(String(describing: response.ca_valid))")
        
        print("Card Code \(String(describing: response.cardCode))")
        
        print("Card Last4 \(String(describing: response.cardLast4))")
        
        print("CVV \(String(describing: response.cvv))")
        
        print("TranRef \(String(describing: response.tranRef))")
        
        
        //Mark:- Save card management it save only one card at time.
        //For save the card you need to store tranRef and when you are going to make second trans using thistranRef
        
        
        
        
    }
    
    
    //Mark:- This method call when user click on cancel button and if payment get failed
    func didPaymentFail() {
        print("Basem didPaymentFail")
       completionHandler?(false)
        self.navigationController?.popToRootViewController(animated: false)
        
    }
    
    func didCancelPayment() {
        print("Basem didCancelPayment")
        
        //        dismiss(animated: false)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    
}
