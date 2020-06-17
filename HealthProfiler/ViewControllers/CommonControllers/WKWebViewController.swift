//
//  WKWebViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 15/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import WebKit
import OAuthSwift

class WKWebViewController: OAuthViewController{
    var webView: WKWebView!
    var targetURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func handle(_ url: URL) {
        targetURL = url
//        super.handle(url)
        loadAddressURL()
    }

    func loadAddressURL() {
        guard let url = targetURL else { return }
        let req = URLRequest(url: url)

        self.webView?.load(req)
    }
}

extension WKWebViewController: WKUIDelegate, WKNavigationDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Check for OAuth Callback
        if let url = navigationAction.request.url, url.scheme == "oauthkeychainapp" {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.dismiss(animated: true, completion: nil)
            decisionHandler(.cancel)
            return
        }

        // Restrict URL's a user can access
        if let host = navigationAction.request.url?.host {
            if host.contains("spotify") {
                decisionHandler(.allow)
                return
            } else {
                // open link outside of our app
                UIApplication.shared.open(navigationAction.request.url!)
                decisionHandler(.cancel)
                return
            }
        }

        decisionHandler(.cancel)

    }
}
