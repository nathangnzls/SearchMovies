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

}
enum AlertAction{
    case okButton
    case cancelButton
}
