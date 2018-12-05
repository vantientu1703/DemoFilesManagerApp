//
//  PreviewImageViewController.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/5/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit

class PreviewImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                if let data = self.document?.fileData {
                    self.imageView.image = UIImage(data: data)
                }
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
