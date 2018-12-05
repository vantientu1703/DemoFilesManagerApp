//
//  DocmentBrowserViewController.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/4/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit

class DocumentBrowserViewController: UIDocumentBrowserViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.allowsPickingMultipleItems = true
        self.allowsDocumentCreation = true
        self.makeData()
    }
    
    private func makeData() {
        let types: [String] = ["docx", "xlsx", "txt", "pdf", "pptx", "svg", "xls", "gif"]
        for type in types {
            let fileName = "sample.\(type)"
            let filePath = Bundle.main.path(forResource: "sample", ofType: type)
            if let urlString = filePath {
                let data = try? Data(contentsOf: URL(fileURLWithPath: urlString), options: .mappedIfSafe)
                data?.saveToFile(fileName)
            }
        }
    }
}

extension DocumentBrowserViewController: UIDocumentBrowserViewControllerDelegate {
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        let newDocumentURL: URL? = nil
        if newDocumentURL != nil {
            importHandler(newDocumentURL, .move)
        } else {
            importHandler(nil, .none)
        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        print("Import file to failed")
    }
    
    func presentDocument(at documentURL: URL) {
        
        // #3.1 - Get the UIViewController scene on the right side of Main.storyboard
        // which is backed by the DocumentViewController class in the
        // DocumentViewController.swift file and instantiate it.
        // That's my custom UI.
        
        // #3.2 - In the template project, the DocumentViewController
        // class has a member "document" of type UIDocument, which is an
        // "abstract base class." I had to subclass UIDocument.
        // I then initialize my UIDocument subclass.
        let document = Document(fileURL: documentURL)
        let webViewVC = WebViewController()
        webViewVC.document = document
        
        let nav = UINavigationController(rootViewController: webViewVC)
        self.present(nav, animated: true, completion: nil)
        /*
        if let typeName = document.fileType {
            guard let name = typeName.split(separator: ".").last else { return }
            guard let fileType = FileType(rawValue: String(name)) else { return }
            // #4.2 - I only support .PNG and .JPG type image files.
            switch fileType {
            case .gif, .JPG, .png, .jpg, .heic, .jpeg, .svg:
                /*
                let previewImageController = storyBoard.instantiateViewController(withIdentifier: "PreviewImageViewController") as! PreviewImageViewController
                previewImageController.document = document
                let nav = UINavigationController(rootViewController: previewImageController)
                self.present(nav, animated: true, completion: nil)
                */
                let webViewVC = WebViewController()
                webViewVC.document = document
                
                let nav = UINavigationController(rootViewController: webViewVC)
                self.present(nav, animated: true, completion: nil)
                break
            case .planText, .cHeader, .cPlusPlusSource, .objectiveCSource, .precompiledCHeader, .swiftSource:
                let documentViewController = storyBoard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
                documentViewController.document = document
                
                let webViewVC = WebViewController()
                webViewVC.document = document
                
                let nav = UINavigationController(rootViewController: webViewVC)
                self.present(nav, animated: true, completion: nil)
                break
            default:
                print("File type unsupported.")
                break
            }
        }
        */
    }
}
