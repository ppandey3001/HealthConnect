//
//  AppContainer.swift
//  HealthProfiler
//

import UIKit

public extension UIViewController {
    
    func container() -> AppContainer? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is AppContainer {
                return viewController as? AppContainer
            }
            viewController = viewController?.parent
        }
        return nil
    }
}

public class AppContainer: UIViewController {

    @IBOutlet private var headerContainerView: UIView!
    @IBOutlet private var customStatusBar: UIView!
    @IBOutlet private var brandingHeaderBarView: UIView!
    @IBOutlet private var brandingLogoImageView: UIImageView!
    @IBOutlet private var brandingTitleLabel: UILabel!
    @IBOutlet private var statusBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var containerView: UIView!
    
    private var childController: UIViewController!
    
    init(_ child: UIViewController) {
        
        super.init(nibName: nil, bundle: nil)
        self.childController = child
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override public func viewSafeAreaInsetsDidChange() {

        let topPadding = view.safeAreaInsets.top
        statusBarHeightConstraint.constant = topPadding
    }
}

//MARK: Private methods
private extension AppContainer {
    
    private func setupController() {
     
        //setup top status bar
        customStatusBar.backgroundColor = UIColor.orange
        if #available(iOS 11.0, *) {
            customStatusBar.isHidden = false

            let topPadding = view.safeAreaInsets.top
            statusBarHeightConstraint.constant = topPadding
        } else {
            customStatusBar.isHidden = true
        }
        
        //set branding logo and title
        resetBranding(logo: UIImage(named: "optum-logo.png"), title: "Health Profiler")
        
        if let child = childController {
            addChildController(child)
        }
    }
    
    private func resetBranding(logo: UIImage?, title: String?) {
        
        brandingLogoImageView.image = logo
        brandingTitleLabel.text = title
    }
    
    private func addChildController(_ controller: UIViewController) {
        
        controller.view.frame = containerView.bounds
        controller.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}

//MARK: Public methods
extension AppContainer {
    
    func showBrandingBar(_ show: Bool) {
        
        brandingHeaderBarView.isHidden = !show
        view.layoutSubviews()
    }
    
}

