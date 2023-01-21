//
//  UIWindow + Ext.swift
//  MovieAppDb
//
//  Created by Sait Cihaner on 21.01.2023.
//

import UIKit

extension UIWindow {

    func showWaitingView(message: String?) {
        let waitingViewTag = 1234
        DispatchQueue.main.async {
            var bgView = self.viewWithTag(waitingViewTag)

            if bgView == nil {
                bgView = UIView(frame: self.frame)
                bgView?.tag = waitingViewTag
                bgView?.backgroundColor = .clear

                let bgDimView = UIView(frame: self.frame)
                bgDimView.alpha = 0.5
                bgDimView.backgroundColor = .black
                bgView?.addSubview(bgDimView)

                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 180, height: 120))
                activityIndicator.style = .medium
                activityIndicator.startAnimating()
                bgView?.addSubview(activityIndicator)

                let messageLabel = UILabel(frame: CGRect(x: 0, y: 75, width: 180, height: 40))
                messageLabel.backgroundColor = UIColor.clear
                messageLabel.textAlignment = .center
                messageLabel.text = message
                messageLabel.font = UIFont.systemFont(ofSize: 14)
                messageLabel.textColor = .white
                messageLabel.numberOfLines = 0
                activityIndicator.addSubview(messageLabel)
                activityIndicator.center = bgView!.center

                self.addSubview(bgView!)
            }

            UIView.animate(withDuration: 0.4, delay: 0, options: .beginFromCurrentState, animations: {
                bgView?.alpha = 1
            }, completion: nil)
        }
    }

    func hideWaitingView() {
        DispatchQueue.main.async {
            let bgView = self.viewWithTag(1234)
            bgView?.removeFromSuperview()
        }
    }
}
