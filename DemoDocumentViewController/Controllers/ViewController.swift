//
//  ViewController.swift
//  DemoDocumentViewController
//
//  Created by van.tien.tu on 12/4/18.
//  Copyright © 2018 van.tien.tu.com. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    /// Creating UIDocumentInteractionController instance.
    let documentInteractionController = UIDocumentInteractionController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        documentInteractionController.delegate = self
    }
    
    @IBAction func showImageAction(_ sender: Any) {
        /// Passing the remote URL of the file, to be stored and then opted with mutliple actions for the user to perform
        self.storedImage(withURLString: "https://vignette.wikia.nocookie.net/fantendo/images/6/6e/Small-mario.png/revision/latest?cb=20120718024112")
    }
}

extension ViewController {
    /// This function will set all the required properties, and then provide a preview for the document
    func previewImage(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    /// This function will store your document to some temporary URL and then provide sharing, copying, printing, saving options to the user
    func storedImage(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        /// START YOUR ACTIVITY INDICATOR HERE
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            let fileName = formatter.string(from: Date()) + ".png"
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? fileName)
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                /// STOP YOUR ACTIVITY INDICATOR HERE
                self.previewImage(url: tmpURL)
            }
        }.resume()
    }
}

extension ViewController: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
