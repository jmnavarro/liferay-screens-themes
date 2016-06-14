/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import Foundation
import LiferayScreens


public class DemoProgressPresenter: MBProgressHUDPresenter {

	private let _spinner: UIActivityIndicatorView
	private let _progressView: UIView?

	public init(spinner: UIActivityIndicatorView, progressView: UIView?) {
		_spinner = spinner
		_progressView = progressView

		(_progressView ?? spinner).hidden = true

		super.init()
	}

	public override func showHUDInView(view: UIView,
			message: String?,
			closeMode: ProgressCloseMode,
			spinnerMode: ProgressSpinnerMode) {

		hideHUD()

		if spinnerMode == .NoSpinner {
			super.showHUDInView(view,
				message: message,
				closeMode: closeMode,
				spinnerMode: spinnerMode)
		}
		else {
			_spinner.startAnimating()
			(_progressView ?? _spinner).hidden = false
		}
	}

	public override func hideHUD() {
		if !(_progressView ?? _spinner).hidden {
			_spinner.stopAnimating()
			(_progressView ?? _spinner).hidden = true
		}
		else {
			super.hideHUD()
		}
	}

}
