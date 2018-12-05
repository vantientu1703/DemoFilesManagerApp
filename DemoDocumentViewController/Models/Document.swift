import UIKit

// #1.0 - Subclass UIDocument to add a data
// model and provide functionality to read and
// write model data.

enum FileType: String {
    //image
    case gif = "gif"
    case JPG = "JPG"
    case png = "png"
    case jpg = "jpg"
    case heic = "heic"
    case jpeg = "jpeg"
    case svg = "svg"
    
    //video
    case mov = "mov"
    case mp4 = "mp4"
    case m4v = "m4v"
    case bagp = "3gp"
    
    //doc
    case pdf = "pdf"
    case doc = "doc"
    case docx = "docx"
    case ppt = "ppt"
    case pptx = "pptx"
    case xls = "xls"
    case xlsx = "xlsx"
    
    //show thumnail
    case key = "key"
    case mp3 = "mp3"
    case num = "numbers"
    case page = "pages"
    case zip = "zip"
    case unknow = "unknow"
    
    // public text
    case planText = "plain-text"
    case swiftSource = "swift-source"
    case objectiveCSource = "objective-c-source"
    case precompiledCHeader = "precompiled-c-header"
    case cHeader = "c-header"
    case cPlusPlusSource = "c-plus-plus-source"
}


class Document: UIDocument {
    
    var fileData: Data?
    var filesText: String?
    // #3.0 - Use this for WRITING/SAVING files. I only allow
    // editing/saving of text files, not image files.
    // "Override this method to return the document data to be saved."
    override func contents(forType typeName: String) throws -> Any {
        // #3.1 - UIDocument knows what type of file it
        // currently represents. The file type is passed
        // to this method when it's called during saves.
        if typeName == "public.plain-text" {
            // #3.2 - Use optional binding to find out
            // whether the "filesText" optional contains a value.
            if let content = self.filesText {
                // #3.3 - Return a Data instance containing
                // a representation of the String encoded using
                // UTF-8 (basically, plain text).
                let data = content.data(using: .utf8)
                return data!
            } else {
                return Data()
            }
        } else {
            return Data()
        }
    }
    // #4.0 - "load" is called soon after "open"; used for READING data
    // from the user-selected document and storing that data
    // in the UIDocument's model. Called when document is opened.
    // "Override this method to load the document data into the app's data model."
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // #4.1 - We can only read data if we know
        // what type of file we're reading from.
        if let typeName = typeName {
            guard let name = typeName.split(separator: ".").last else { return }
            guard let fileType = FileType(rawValue: String(name)) else { return }
            // #4.2 - I only support .PNG and .JPG type image files.
            switch fileType {
            case .gif, .JPG, .png, .jpg, .heic, .jpeg, .svg:
                if let fileContents = contents as? Data {
                    self.fileData = fileContents
                }
                break
            case .planText, .cHeader, .cPlusPlusSource, .objectiveCSource, .precompiledCHeader, .swiftSource:
                if let fileContents = contents as? Data {
                    self.filesText = String(data: fileContents, encoding: .utf8)
                }
                break
            default:
                print("File type unsupported.")
                break
            }
        }
    }
    // #5.0 - "A UIDocument object has a specific state at
    // any moment in its life cycle. You can check
    // the current state by querying the documentState
    // property..." State can help us in debugging.
    public var state: String {
        switch documentState {
        case .normal:
            return "Normal"
        case .closed:
            return "Closed"
        case .inConflict:
            return "Conflict"
        case .savingError:
            return "Save Error"
        case .editingDisabled:
            return "Editing Disabled"
        case .progressAvailable:
            return "Progress Available"
        default:
            return "Unknown"
        }
    } // end public var state
} // end class Document
