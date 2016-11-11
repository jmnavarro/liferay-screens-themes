//
//  ViewController.swift
//  Example
//
//  Created by Victor Galán on 10/11/16.
//  Copyright © 2016 liferay. All rights reserved.
//

import UIKit
import LiferayScreens

class ViewController: UIViewController, LoginScreenletDelegate {

	@IBOutlet weak var loginScreenlet: LoginScreenlet!

	override func viewDidLoad() {
		super.viewDidLoad()

		loginScreenlet.delegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func screenlet(screenlet: BaseScreenlet,
	               onLoginResponseUserAttributes attributes: [String:AnyObject]) {
		performSegueWithIdentifier("login", sender: nil)
	}
}

