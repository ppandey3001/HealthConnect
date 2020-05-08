//
//  Loader.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 08/05/20.
//  Copyright © 2019 Pandey, Pooja. All rights reserved.
//

import Foundation
import UIKit

internal class Loader : UIView {
    
    // MARK: - Properties
    var statusFont: UIFont?
    var statusColor: UIColor?
    var spinnerColor: UIColor?
    var hudColor: UIColor?
    var bgColor: UIColor?
    var imageSuccess: UIImage?
    var imageError: UIImage?
    var appWindow: UIWindow?
    var viewBackground: UIView?
    var toolbar: UIToolbar?
    var spinner: UIActivityIndicatorView?
    var imageView: UIImageView?
    var labelStatus: UILabel?
    
    //MARK:- Initialization
    private static let shared : Loader = {
        let instance = Loader()
        return instance
    }()
    
    private init() {
        super.init(frame: UIScreen.main.bounds)
        statusFont = UIFont.boldSystemFont(ofSize: 16)
        statusColor = UIColor.black
        spinnerColor = UIColor.gray
        hudColor = UIColor(white: 0.0, alpha: 0.1)
        bgColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        let bundle = Bundle(for: type(of: self))
        imageSuccess = UIImage(named: "", in: bundle, compatibleWith: nil)
        imageError = UIImage(named: "", in: bundle, compatibleWith: nil)
        
        let delegate: UIApplicationDelegate? = UIApplication.shared.delegate
        
        if let window = delegate?.window {
            appWindow = window
        } else {
            appWindow = UIApplication.shared.keyWindow
        }
        
        viewBackground = nil
        toolbar = nil
        spinner = nil
        imageView = nil
        labelStatus = nil
        
        self.alpha = 0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLoader(_ status: String?, image: UIImage?, spin: Bool, hide: Bool, interaction: Bool) {
        if toolbar == nil {
            toolbar = UIToolbar(frame: CGRect.zero)
            toolbar?.isTranslucent = true
            toolbar?.backgroundColor = hudColor
            toolbar?.layer.cornerRadius = 10
            toolbar?.layer.masksToBounds = true
        }
        if let toolbar = self.toolbar, let window = self.appWindow, toolbar.superview == nil {
            if interaction == false {
                viewBackground = UIView(frame: window.frame)
                viewBackground?.backgroundColor = bgColor
                window.addSubview(viewBackground!)
                viewBackground?.addSubview(toolbar)
            } else {
                window.addSubview(toolbar)
            }
        }
        
        if spinner == nil {
            spinner = UIActivityIndicatorView(style: .whiteLarge)
            spinner?.color = spinnerColor
            spinner?.hidesWhenStopped = true
            
            if spinner?.superview == nil {
                self.toolbar?.addSubview(spinner!)
            }
        }
        
        if imageView == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
            
            if imageView?.superview == nil {
                self.toolbar?.addSubview(imageView!)
            }
        }
        
        if labelStatus == nil {
            labelStatus = UILabel(frame: CGRect.zero)
            labelStatus?.font = statusFont
            labelStatus?.textColor = statusColor
            labelStatus?.backgroundColor = UIColor.clear
            labelStatus?.textAlignment = .center
            labelStatus?.baselineAdjustment = .alignCenters
            labelStatus?.numberOfLines = 0
            
            if labelStatus?.superview == nil {
                self.toolbar?.addSubview(labelStatus!)
            }
            
            labelStatus?.text = status
            labelStatus?.isHidden = (status == nil) ? true : false
            imageView?.image = image
            imageView?.isHidden = (image == nil) ? true : false
        }
        
        
        if spin {
            spinner?.startAnimating()
        } else {
            spinner?.stopAnimating()
        }
        hudSize()
        hudPosition(nil)
        loaderShow()
    }
    
    
    // MARK: - Display methods
    class func dismiss() {
        DispatchQueue.main.async(execute: {
            self.shared.hideLoader()
        })
    }
    
    class func show() {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(nil, image: nil, spin: true, hide: false, interaction: false)
        })
    }
    
    class func show(_ status: String?) {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(status, image: nil, spin: true, hide: false, interaction: false)
        })
    }
    
    class func show(_ status: String?, interaction: Bool) {
        
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(status, image: nil, spin: true, hide: false, interaction: interaction)
        })
    }
    
    class func showSuccess() {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(nil, image: self.shared.imageSuccess, spin: false, hide: true, interaction: false)
        })
    }
    
    class func showSuccess(_ status: String?) {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(status, image: self.shared.imageSuccess, spin: false, hide: true, interaction: false)
        })
    }
    
    class func showSuccess(_ status: String?, interaction: Bool) {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(status, image: self.shared.imageSuccess, spin: false, hide: true, interaction: interaction)
        })
    }
    
    class func showError() {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(nil, image: self.shared.imageError, spin: false, hide: true, interaction: false)
        })
    }
    
    class func showError(_ status: String?) {
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(status, image: self.shared.imageError, spin: false, hide: true, interaction: false)
        })
    }
    
    class func showError(_ status: String?, interaction: Bool) {
        
        DispatchQueue.main.async(execute: {
            self.shared.createLoader(status, image: self.shared.imageError, spin: false, hide: true, interaction: interaction)
        })
    }
    
    //MARK:- Property methods
    class func statusFont(_ font: UIFont?) {
        self.shared.statusFont = font
    }
    
    class func statusColor(_ color: UIColor?) {
        self.shared.statusColor = color
    }
    
    class func spinnerColor(_ color: UIColor?) {
        self.shared.spinnerColor = color
    }
    
    class func hudColor(_ color: UIColor?) {
        self.shared.hudColor = color
    }
    
    class func backgroundColor(_ color: UIColor?) {
        self.shared.bgColor = color
    }
    
    class func imageSuccess(_ image: UIImage?) {
        self.shared.imageSuccess = image
    }
    
    class func imageError(_ image: UIImage?) {
        self.shared.imageError = image
    }
    
    //MARK:- Notification Register
    private func loaderRemove() {
        
        NotificationCenter.default.removeObserver(self)
        labelStatus?.removeFromSuperview()
        labelStatus = nil
        imageView?.removeFromSuperview()
        imageView = nil
        spinner?.removeFromSuperview()
        spinner = nil
        toolbar?.removeFromSuperview()
        toolbar = nil
        viewBackground?.removeFromSuperview()
        viewBackground = nil
    }
    
    //MARK:- Loader Size, Position
    private func hudSize() {
        
        var rectLabel = CGRect.zero
        var widthHUD: CGFloat = 100
        var heightHUD: CGFloat = 100
        
        if let labelStatus = self.labelStatus,
            let text = labelStatus.text, text.count > 0,
            let font = labelStatus.font {
            let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
            let options: NSStringDrawingOptions = [.usesFontLeading, .truncatesLastVisibleLine, .usesLineFragmentOrigin]
            rectLabel = text.boundingRect(with: CGSize(width: 200, height: 300), options: options, attributes: attributes, context: nil)
            
            widthHUD = rectLabel.size.width + 50
            heightHUD = rectLabel.size.height + 75
            
            if widthHUD < 100 {
                widthHUD = 100
            }
            if heightHUD < 100 {
                heightHUD = 100
            }
            
            rectLabel.origin.x = (widthHUD - rectLabel.size.width) / 2
            rectLabel.origin.y = (heightHUD - rectLabel.size.height) / 2 + 25
        }
        
        self.toolbar?.bounds = CGRect(x: 0, y: 0, width: widthHUD, height: heightHUD)
        
        let imageX: CGFloat = widthHUD / 2
        let imageY: CGFloat = ((self.labelStatus?.text?.count ?? 0) == 0) ? heightHUD / 2 : 36
        if let spinner = self.spinner {
            spinner.center = CGPoint(x: imageX, y: imageY)
            imageView?.center = spinner.center
            labelStatus?.frame = rectLabel
        }
    }
    
    @objc func hudPosition(_ notification: Notification?) {
        var heightKeyboard: CGFloat = 0
        var duration: TimeInterval = 0
        if let info = notification?.userInfo {
            if let keyboardFrame: NSValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                heightKeyboard = keyboardHeight
            }
            if let double = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                duration = TimeInterval(double)
            }
        } else {
            heightKeyboard = keyboardHeight()
        }
        
        let screen: CGRect = UIScreen.main.bounds
        let center = CGPoint(x: screen.size.width / 2, y: (screen.size.height - heightKeyboard) / 2)
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.toolbar?.center = CGPoint(x: center.x, y: center.y)
        })
        
        if let viewBackground = self.viewBackground, let window = self.appWindow {
            viewBackground.frame = window.frame
        }
    }
    
    
    private func keyboardHeight() -> CGFloat {
        for testWindow: UIWindow in UIApplication.shared.windows {
            for possibleKeyboard: UIView in testWindow.subviews {
                if possibleKeyboard.description.hasPrefix("<UIPeripheralHostView") {
                    return possibleKeyboard.bounds.size.height
                } else if possibleKeyboard.description.hasPrefix("<UIInputSetContainerView") {
                    for hostKeyboard: UIView in possibleKeyboard.subviews {
                        if hostKeyboard.description.hasPrefix("<UIInputSetHost") {
                            return hostKeyboard.frame.size.height
                        }
                    }
                }
                else {
                    return 0
                }
            }
        }
        return 0
    }
    
    //MARK:- Loader Show, Hide
    private func loaderShow() {
        if alpha == 0 {
            alpha = 1
            if let toolbar  =  self.toolbar {
                toolbar.alpha = 0
                toolbar.transform = toolbar.transform.scaledBy(x: 1.4, y: 1.4)
                
                let options:UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
                UIView.animate(withDuration: 0.15, delay: 0, options: options, animations: {
                    toolbar.transform = toolbar.transform.scaledBy(x: 1 / 1.4, y: 1 / 1.4)
                    toolbar.alpha = 1
                })
            }
        }
    }
    
    private func hideLoader() {
        if alpha == 1 {
            if let toolbar  =  self.toolbar {
                let options:UIView.AnimationOptions = [.allowUserInteraction, .curveEaseIn]
                UIView.animate(withDuration: 0.15, delay: 0, options: options, animations: {
                    toolbar.transform = toolbar.transform.scaledBy(x: 0.7, y: 0.7)
                    toolbar.alpha = 0
                }) { finished in
                    self.loaderRemove()
                    self.alpha = 0
                }
            }
        }
    }
}
