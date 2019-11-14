//
//  BaseViewController.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showNoInternetAlert(){
        self.showAlert(title: alertsTitle.internetRequired, message: alertsMessage.internetRequired, handler: {
            (AlertAction) in
            switch AlertAction{
            case .okButton:
                print("Okay")
            case .cancelButton:
                print("cancel")
            }
        })
    }
    func showAlert(title: String , message: String , handler:@escaping(AlertAction)->Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default")
            handler(AlertAction.okButton)
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func showMain(){
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainSB") as UIViewController
        viewController.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            viewController.isModalInPresentation = true // available in IOS13
        }
        //UIApplication.topViewController(viewController: viewController)?.present(viewController, animated: true, completion: nil)
        self.present(viewController, animated: true, completion: nil)
    }
}
extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
enum AlertAction{
    case okButton
    case cancelButton
}
