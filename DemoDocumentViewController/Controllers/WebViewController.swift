//
//  WebViewController.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/5/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    fileprivate var webView: WKWebView?
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
        self.webView = WKWebView(frame: UIScreen.main.bounds)
        if let webView = self.webView {
            guard let url = self.document?.fileURL else { return }
            self.title = url.lastPathComponent
            webView.loadFileURL(url, allowingReadAccessTo: url)
            self.view.addSubview(webView)
        }
    }
    
    private func setupView() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
