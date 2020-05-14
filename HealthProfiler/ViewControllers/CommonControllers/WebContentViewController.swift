//
//  WebContentViewController.swift
//  HealthProfiler
//

import UIKit
import WebKit

class WebContentViewController: HPViewController {

    @IBOutlet var webView_content: WKWebView!
    @IBOutlet weak var activityIndicator_webPage: UIActivityIndicatorView!

    var type = HPWebContentType.privacyPolicy
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}

//MARK: Private methods
private extension WebContentViewController {
    
    private func setupController() {

        webView_content.navigationDelegate = self
        
        var htmlString: String?
        
        switch type {
        case .privacyPolicy:
            htmlString = getHTMLContent(type: .privacyPolicy)
            
        case .termsCondition:
               htmlString = getHTMLContent(type: .privacyPolicy)
           
        case .content(let html):
               htmlString = html
        }
        
        if let html = htmlString {
            webView_content.loadHTMLString(html, baseURL: nil)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self , action: #selector(buttonAction_done))
    }
    
    private func getHTMLContent(type: ResourceType) -> String? {
        
        var html: String?
        
        if let fileData = AppResource.getData(type: type) {
            html = String(data: fileData, encoding: .utf8)
        }

        return html
    }
    
    @objc private func buttonAction_done() {
        
        self.dismiss(animated: true) { }
    }
}


extension WebContentViewController: WKNavigationDelegate {
    
    //WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator_webPage.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator_webPage.stopAnimating()
        
        if error.localizedDescription == "Plug-in handled load" {
            return
        }
        
        showRetryAlert(title: "Error", message: "\(error.localizedDescription)\nRetry?", retryAction: {
            webView.reload()
        }) {
            self.dismiss(animated: true) { }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator_webPage.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
}
