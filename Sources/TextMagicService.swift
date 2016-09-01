/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit
import Diff

public struct TextMagicService {
    
    public init() { }
    
    /**
     Updates text in `textInput` while preserving cursor position
     and selected text range.
     
     - Note: Changes should be coalesced so that all changes can be
        represented with a single diff. E.g. "the original text" could
        be changed to "the changed text" or "some original text" or
        "original text", but not "some original words" or cursor
        position or selected text range will be lost.
     
     - Parameters:
        - textInput:    Either `UITextField` or `UITextView`
        - newString:    Text to replace in `textInput`
     */
    public func updateText(in textInput: UITextInput?, newString: String?) {
        guard let textInput = textInput else { return }
        let oldText: String
        if let textField = textInput as? UITextField, text = textField.text {
            oldText = text
        } else if let textView = textInput as? UITextView, text = textView.text {
            oldText = text
        } else {
            return
        }
        guard let newString = newString, (diffRange, changedText) = diff(oldText, newString), selectedRange = textInput.selectedTextRange else { return }
        if let textField = textInput as? UITextField {
            textField.text = newString
        } else if let textView = textInput as? UITextView {
            textView.text = newString
        }
        
        let cursorOffset = textInput.offsetFromPosition(textInput.beginningOfDocument, toPosition: selectedRange.start)
        let selectedEndOffset = textInput.offsetFromPosition(textInput.beginningOfDocument, toPosition: selectedRange.end)
        let selectedRangeLength = selectedEndOffset - cursorOffset
        
        if selectedEndOffset < diffRange.startIndex {
            // Change is after current cursor
            moveCursorRelativeToBeginning(in: textInput, offset: cursorOffset, rangeLength: selectedRangeLength)
        } else if cursorOffset < diffRange.startIndex && selectedEndOffset > diffRange.endIndex {
            // Change occurs within selection
            moveCursorRelativeToBeginning(in: textInput, offset:  cursorOffset, rangeLength: selectedRangeLength + changedText.characters.count - diffRange.count)
        } else if cursorOffset >= diffRange.endIndex {
            // Change occurs completely before current cursor
            moveCursorRelativeToBeginning(in: textInput, offset:  cursorOffset + changedText.characters.count - diffRange.count, rangeLength: selectedRangeLength)
        } else if diffRange.startIndex < selectedEndOffset && diffRange.startIndex > cursorOffset {
            // Change starts in middle of selection
            moveCursorRelativeToBeginning(in: textInput, offset:  cursorOffset, rangeLength: selectedRangeLength - (selectedEndOffset - diffRange.startIndex))
        } else if diffRange.startIndex <= cursorOffset && cursorOffset < diffRange.endIndex {
            // Change is a removal/change over the current cursor position
            let rangeLength = selectedRangeLength - (diffRange.endIndex - cursorOffset)
            moveCursorRelativeToBeginning(in: textInput, offset:  cursorOffset - (cursorOffset - diffRange.startIndex) + changedText.characters.count, rangeLength: rangeLength > 0 ? rangeLength : 0)
        }
    }
    
}


// MARK: - Private functions

private extension TextMagicService {
    
    private func moveCursorRelativeToBeginning(in textInput: UITextInput, offset: Int, rangeLength: Int = 0) {
        guard let startPosition = textInput.positionFromPosition(textInput.beginningOfDocument, offset: offset), endPosition = textInput.positionFromPosition(startPosition, offset: rangeLength) else { return }
        textInput.selectedTextRange = textInput.textRangeFromPosition(startPosition, toPosition: endPosition)
    }
    
}
