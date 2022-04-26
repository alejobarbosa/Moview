//
//  BaseViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
        
    ///Method to show an activity indicator
    public func showActivityIndicator(show:Bool) {
        DispatchQueue.main.async {
            if show {
                if let viewIndicator = self.view.viewWithTag(99) {
                    viewIndicator.removeFromSuperview()
                }
                let viewContainer = UIView(frame: CGRect(x: 0, y: 0,
                                                         width: UIScreen.main.bounds.width,
                                                         height: UIScreen.main.bounds.height))
                viewContainer.tag = 99
                viewContainer.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 0.91)
                viewContainer.frame.origin = CGPoint(x: 0, y: 0)
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.color = .white
                activityIndicator.startAnimating()
                activityIndicator.center = viewContainer.center
                viewContainer.addSubview(activityIndicator)
                self.view.addSubview(viewContainer)
            } else {
                let viewIndicator = self.view.viewWithTag(99)
                viewIndicator?.removeFromSuperview()
            }
        }
    }
    
    ///Method to show an alert controller
    public func showErrorView(message: String, handlerAccept: ((UIAlertAction) -> Void)? = nil){
        let alertController = UIAlertController(title: Constants.ErrorView.errorTitle,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.addAction(UIAlertAction(title: Constants.acceptTitle,
                                                style: .default,
                                                handler: handlerAccept))
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///Method to embed a view into a scroll
    public func embedInScroll(_ contentView: UIView, height: CGFloat){
        self.view.layoutIfNeeded()
        contentView.removeFromSuperview()
        let scroll = UIScrollView()
        self.view.addSubview(scroll)
        scroll.addConstraintTopParent()
        scroll.addWidthConstraintParent()
        scroll.addBottomConstraintParent()
        scroll.addConstraintXCenterParent()
        scroll.addSubview(contentView)
        contentView.addConstraintTopParent()
        contentView.addWidthConstraintParent()
        contentView.addConstraintXCenterParent()
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: height)
    }

}
