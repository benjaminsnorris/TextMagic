/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
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
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("unused")
    }
}

struct TestHelpers {
    static let originalText = "Growth and learning\n\nWhat books are you reading?"
}
