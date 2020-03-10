//
//  ViewController.swift
//  PaymentGateway
//
//  Created by Hxtreme on 10/03/20.
//  Copyright © 2020 Hxtreme. All rights reserved.
//

import UIKit
import Braintree
class ViewController: UIViewController {
    
   //Reference Guide
    
    //https://braintree.github.io/braintree_ios/
    
    
    //Braintree login
   // https://sandbox.braintreegateway.com/login
    var braintreeClient: BTAPIClient!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.braintreeClient = BTAPIClient(authorization: "sandbox_tvc92fkk_95wq74b4wt8rng6v")

        
    }
    @IBAction func clickBtnAction(_ sender:Any){
        let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self

        // Start the Vault flow, or...
        payPalDriver.authorizeAccount() { (tokenizedPayPalAccount, error) -> Void in
        }

        // ...start the Checkout flow
        let payPalRequest = BTPayPalRequest(amount: "1.00")
        payPalDriver.requestOneTimePayment(payPalRequest) { (tokenizedPayPalAccount, error) -> Void in
        }
        
        

              // Specify the transaction amount here. "2.32" is used in this example.
              let request = BTPayPalRequest(amount: "2.32")
              request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

              payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                  if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                      print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                      // Access additional information
                      let email = tokenizedPayPalAccount.email
                      let firstName = tokenizedPayPalAccount.firstName
                      let lastName = tokenizedPayPalAccount.lastName
                      let phone = tokenizedPayPalAccount.phone
print("Details \(email) ,\(firstName),\(lastName),\(phone)")
                      // See BTPostalAddress.h for details
                      let billingAddress = tokenizedPayPalAccount.billingAddress
                      let shippingAddress = tokenizedPayPalAccount.shippingAddress
                  } else if let error = error {
                      // Handle error here...
                  } else {
                      // Buyer canceled payment approval
                  }
              }
          }
    }
    
    


extension ViewController:BTViewControllerPresentingDelegate{

func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
    present(viewController, animated: true, completion: nil)
}

func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
    viewController.dismiss(animated: true, completion: nil)
}
}
extension ViewController:BTAppSwitchDelegate{

// MARK: - BTAppSwitchDelegate


// Optional - display and hide loading indicator UI
func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
    showLoadingUI()

   // NotificationCenter.default.addObserver(self, selector: #selector(hideLoadingUI), name: NSNotification.Name.did, object: nil)
}
   

func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
    hideLoadingUI()
}

func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {

}

// MARK: - Private methods

func showLoadingUI() {
    // ...
}

    @objc func hideLoadingUI() {
//NotificationCenter
//        .default
//        .removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//
        
    }
}
