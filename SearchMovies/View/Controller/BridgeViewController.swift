//
//  BridgeViewController.swift
//  SearchMovies
//
//  Created by Nathan on 14/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit
//In this controller we will be going to check which view has to load fist or resume.
class BridgeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(showMain), with: nil, afterDelay: 0)
        // check if the user is logged in.
        //check if there is an update from the app store.
        //check if the app needs a maintenance.
    }
}
