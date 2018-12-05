//
//  DocumentPickerViewController.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/6/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit

class DocumentPickerViewController: UIDocumentPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override init(documentTypes allowedUTIs: [String], in mode: UIDocumentPickerMode) {
        super.init(documentTypes: allowedUTIs, in: mode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
