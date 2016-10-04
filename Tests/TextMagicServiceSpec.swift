/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import XCTest
@testable import TextMagic

class TextMagicServiceSpec: XCTestCase {
    
    var textScreen: TextScreen!
    var service: TextMagicService!
    
    override func setUp() {
        super.setUp()
        textScreen = TextScreen()
        service = TextMagicService()
    }
    
    /// test that it does not cause an error to call update text with nil text input and string
    func testThatItDoesNotCauseAnErrorToCallUpdateTextWithNilTextInputAndString() {
        service.updateText(in: nil, newString: nil)
        XCTAssertNotNil(service)
    }
    
    // MARK: - Text field tests
    
    /// test with text field
    func testWithTextField() {
        moveCursorRelativeToBeginning(in: textScreen.textField, offset: 0)
        
        service.updateText(in: textScreen.textField, newString: TestHelpers.originalText)
        XCTAssertEqual(cursorOffset(in: textScreen.textField), 0)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textField), 0)
    }
    
    /// test with incorrect text field behavior
    func testWithIncorrectTextFieldBehavior() {
        moveCursorRelativeToBeginning(in: textScreen.textField, offset: 11)
        
        let changedText = "Growth and learning"
        service.updateText(in: textScreen.textField, newString: changedText)
        // This should be 11 still
        XCTAssertEqual(cursorOffset(in: textScreen.textField), 0)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textField), 0)
    }
    
    /// test with text field and changes including cursor
    func testWithTextFieldAndChangesIncludingCursor() {
        let changedText = "yearning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textField, newString: changedText)
        // This should be 1
        XCTAssertEqual(cursorOffset(in: textScreen.textField), 0)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textField), 0)
    }
    
    
    // MARK: - Cursor position tests
    
    /// test that cursor position does not change if state changes but agenda is unchanged
    func testThatCursorPositionDoesNotChangeIfStateChangesButAgendaIsUnchanged() {
        verifyThatCursorPositionDoesNotChangeIfStateChangesButAgendaIsUnchanged(with: textScreen.textView)
    }
    
    /// test that cursor position does not change when agenda has changes after cursor
    func testThatCursorPositionDoesNotChangeWhenAgendaHasChangesAfterCursor() {
        verifyThatCursorPositionDoesNotChangeWhenAgendaHasChangesAfterCursor(with: textScreen.textView)
    }
    
    /// test that cursor position changes when agenda has removed text before current cursor position
    func testThatCursorPositionChangesWhenAgendaHasRemovedTextBeforeCurrentCursorPosition() {
        verifyThatCursorPositionChangesWhenAgendaHasRemovedTextBeforeCurrentCursorPosition(with: textScreen.textView)
    }
    
    /// test that cursor position changes when agenda has changed text before current cursor position
    func testThatCursorPositionChangesWhenAgendaHasChangedTextBeforeCurrentCursorPosition() {
        verifyThatCursorPositionChangesWhenAgendaHasChangedTextBeforeCurrentCursorPosition(with: textScreen.textView)
    }
    
    /// test that cursor position changes when agenda has removed text that includes current cursor position
    func testThatCursorPositionChangesWhenAgendaHasRemovedTextThatIncludesCurrentCursorPosition() {
        verifyThatCursorPositionChangesWhenAgendaHasRemovedTextThatIncludesCurrentCursorPosition(with: textScreen.textView)
    }
    
    /// test that cursor position changes when agenda has changed text that includes current cursor position
    func testThatCursorPositionChangesWhenAgendaHasChangedTextThatIncludesCurrentCursorPosition() {
        verifyThatCursorPositionChangesWhenAgendaHasChangedTextThatIncludesCurrentCursorPosition(with: textScreen.textView)
    }
    
    
    // MARK: - Selected text tests
    
    /// test that text selection does not changes when text does not change
    func testThatTextSelectionDoesNotChangesWhenTextDoesNotChange() {
        verifyThatTextSelectionDoesNotChangesWhenTextDoesNotChange(with: textScreen.textView)
    }
    
    /// test that text selection does not change when text changes occur after selection
    func testThatTextSelectionDoesNotChangeWhenTextChangesOccurAfterSelection() {
        verifyThatTextSelectionDoesNotChangeWhenTextChangesOccurAfterSelection(with: textScreen.textView)
    }
    
    /// test that text selection remains same but moves when text is added before selection
    func testThatTextSelectionRemainsSameButMovesWhenTextIsAddedBeforeSelection() {
        verifyThatTextSelectionRemainsSameButMovesWhenTextIsAddedBeforeSelection(with: textScreen.textView)
    }
    
    /// test that text selection adjusts to include changes that occur within the selection
    func testThatTextSelectionAdjustsToIncludeChangesThatOccurWithinTheSelection() {
        verifyThatTextSelectionAdjustsToIncludeChangesThatOccurWithinTheSelection(with: textScreen.textView)
    }
    
    /// test that text selection expands to include additions that occur within the selection
    func testThatTextSelectionExpandsToIncludeAdditionsThatOccurWithinTheSelection() {
        verifyThatTextSelectionExpandsToIncludeAdditionsThatOccurWithinTheSelection(with: textScreen.textView)
    }
    
    /// test that text selection is truncated when the end of the selection is removed
    func testThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsRemoved() {
        verifyThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsRemoved(with: textScreen.textView)
    }
    
    /// test that text selection is truncated when the end of the selection is changed
    func testThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsChanged() {
        verifyThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsChanged(with: textScreen.textView)
    }
    
    /// test that text selection is truncated when the beginning of the selection is removed
    func testThatTextSelectionIsTruncatedWhenTheBeginningOfTheSelectionIsRemoved() {
        verifyThatTextSelectionIsTruncatedWhenTheBeginningOfTheSelectionIsRemoved(with: textScreen.textView)
    }
    
    /// test that text selection is truncated and moved when the beginning of the selection is changed
    func testThatTextSelectionIsTruncatedAndMovedWhenTheBeginningOfTheSelectionIsChanged() {
        verifyThatTextSelectionIsTruncatedAndMovedWhenTheBeginningOfTheSelectionIsChanged(with: textScreen.textView)
    }
    
    /// test that cursor does not move when the exact selection is removed
    func testThatCursorDoesNotMoveWhenTheExactSelectionIsRemoved() {
        verifyThatCursorDoesNotMoveWhenTheExactSelectionIsRemoved(with: textScreen.textView)
    }
    
    /// test that cursor is moved when entire selection is removed
    func testThatCursorIsMovedWhenEntireSelectionIsRemoved() {
        verifyThatCursorIsMovedWhenEntireSelectionIsRemoved(with: textScreen.textView)
    }
    
    /// test that cursor is moved when entire selection is changed
    func testThatCursorIsMovedWhenEntireSelectionIsChanged() {
        verifyThatCursorIsMovedWhenEntireSelectionIsChanged(with: textScreen.textView)
    }

}


// MARK: - Private test functions {

private extension TextMagicServiceSpec {
    
    
    // MARK: - Cursor position verifications
    
    /// verify that cursor position does not change if state changes but agenda is unchanged
    func verifyThatCursorPositionDoesNotChangeIfStateChangesButAgendaIsUnchanged(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 11)
        XCTAssertEqual(cursorOffset(in: textInput), 11)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
        
        service.updateText(in: textInput, newString: TestHelpers.originalText)
        XCTAssertEqual(cursorOffset(in: textInput), 11)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor position does not change when agenda has changes after cursor
    func verifyThatCursorPositionDoesNotChangeWhenAgendaHasChangesAfterCursor(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 11)
        
        let changedText = "Growth and learning"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 11)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor position changes when agenda has removed text before current cursor position
    func verifyThatCursorPositionChangesWhenAgendaHasRemovedTextBeforeCurrentCursorPosition(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 11)
        
        let changedText = "and learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 4)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor position changes when agenda has changed text before current cursor position
    func verifyThatCursorPositionChangesWhenAgendaHasChangedTextBeforeCurrentCursorPosition(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 11)
        
        let changedText = "Growing and learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 12)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor position changes when agenda has removed text that includes current cursor position
    func verifyThatCursorPositionChangesWhenAgendaHasRemovedTextThatIncludesCurrentCursorPosition(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 11)
        
        let changedText = "Growth \n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor position changes when agenda has changed text that includes current cursor position
    func verifyThatCursorPositionChangesWhenAgendaHasChangedTextThatIncludesCurrentCursorPosition(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 11)
        
        let changedText = "Growth & career development\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 27)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    
    // MARK: - Selected text verifications
    
    /// verify that text selection does not changes when text does not change
    func verifyThatTextSelectionDoesNotChangesWhenTextDoesNotChange(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 3)
        
        service.updateText(in: textInput, newString: TestHelpers.originalText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 3)
    }
    
    /// verify that text selection does not change when text changes occur after selection
    func verifyThatTextSelectionDoesNotChangeWhenTextChangesOccurAfterSelection(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth and learning\n\nWhat are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 3)
    }
    
    /// verify that text selection remains same but moves when text is added before selection
    func verifyThatTextSelectionRemainsSameButMovesWhenTextIsAddedBeforeSelection(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth, development and learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 20)
        XCTAssertEqual(selectedRangeLength(in: textInput), 3)
    }
    
    /// verify that text selection adjusts to include changes that occur within the selection
    func verifyThatTextSelectionAdjustsToIncludeChangesThatOccurWithinTheSelection(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth ad learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 2)
    }
    
    /// verify that text selection expands to include additions that occur within the selection
    func verifyThatTextSelectionExpandsToIncludeAdditionsThatOccurWithinTheSelection(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth any time we did learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 15)
    }
    
    /// verify that text selection is truncated when the end of the selection is removed
    func verifyThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsRemoved(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth an learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 2)
    }
    
    /// verify that text selection is truncated when the end of the selection is changed
    func verifyThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsChanged(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth any learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 2)
    }
    
    /// verify that text selection is truncated when the beginning of the selection is removed
    func verifyThatTextSelectionIsTruncatedWhenTheBeginningOfTheSelectionIsRemoved(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth d learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 1)
    }
    
    /// verify that text selection is truncated and moved when the beginning of the selection is changed
    func verifyThatTextSelectionIsTruncatedAndMovedWhenTheBeginningOfTheSelectionIsChanged(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth that does not end learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 22)
        XCTAssertEqual(selectedRangeLength(in: textInput), 2)
    }
    
    /// verify that cursor does not move when the exact selection is removed
    func verifyThatCursorDoesNotMoveWhenTheExactSelectionIsRemoved(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 7)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor is moved when entire selection is removed
    func verifyThatCursorIsMovedWhenEntireSelectionIsRemoved(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growthlearning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 6)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }
    
    /// verify that cursor is moved when entire selection is changed
    func verifyThatCursorIsMovedWhenEntireSelectionIsChanged(with textInput: UITextInput) {
        (textInput as! UIResponder).becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textInput, offset: 7, length: 3)
        
        let changedText = "Growth or learning\n\nWhat books are you reading?"
        service.updateText(in: textInput, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textInput), 9)
        XCTAssertEqual(selectedRangeLength(in: textInput), 0)
    }

}


// MARK: - Private helper functions

private extension TextMagicServiceSpec {
    
    func cursorOffset(in textInput: UITextInput) -> Int {
        guard let selectedRange = textInput.selectedTextRange else { return 0 }
        return textInput.offset(from: textInput.beginningOfDocument, to: selectedRange.start)
    }
    
    func selectedRangeLength(in textInput: UITextInput) -> Int {
        guard let selectedRange = textInput.selectedTextRange else { return 0 }
        return textInput.offset(from: textInput.beginningOfDocument, to: selectedRange.end) - cursorOffset(in: textInput)
    }
    
    func moveCursorRelativeToBeginning(in textInput: UITextInput, offset: Int, length: Int = 0) {
        guard let startPosition = textInput.position(from: textInput.beginningOfDocument, offset: offset), let endPosition = textInput.position(from: startPosition, offset: length) else { return }
        textInput.selectedTextRange = textInput.textRange(from: startPosition, to: endPosition)
    }

}
