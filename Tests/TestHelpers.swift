/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

class TextScreen: UIViewController {
    let textView = UITextView()
    let textField = UITextField()
    init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubview(textView)
        textView.text = TestHelpers.originalText
        view.addSubview(textField)
        textField.text = TestHelpers.originalText
        textField.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("unused")
    }
}

struct TestHelpers {
    static let originalText = "Growth and learning\n\nWhat books are you reading?"
}
