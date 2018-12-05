//
//  DocumentViewController.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/5/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadDocument()
    }
    
    private func loadDocument() {
        self.document?.open(completionHandler: { (success) in
            if success {
                self.title = self.document?.fileURL.lastPathComponent
                self.textView.text = self.document?.filesText
            } else {
                //TODO
            }
        })
    }
    
    private func setupView() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
