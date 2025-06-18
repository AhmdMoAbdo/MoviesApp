//
//  WebViewController.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    let url: URL
    
    // MARK: - Initializer(s)
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - Back Button handling
    private func setupBackButton() {
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonTapped(_:))))
    }
    
    @objc func backButtonTapped(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}

// MARK: - Web View Delegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stopLoadingIndicator()
    }
}
