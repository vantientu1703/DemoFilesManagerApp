//
//  Data+Ext.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/6/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit

extension Data {
    func saveToFile(_ fileName: String) {
        let fileManager = FileManager.default
        let filePath = fileManager.temporaryDirectory.appendingPathComponent(fileName)
        print(filePath)
        do {
            try self.write(to: filePath)
        } catch {
            print("Save errors")
        }
    }
}
