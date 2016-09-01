/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import XCTest
@testable import TextMagic

class TextMagicServiceTextViewSpec: XCTestCase {
    
    var textScreen: TextScreen!
    var service: TextMagicService!
    
    override func setUp() {
        super.setUp()
        textScreen = TextScreen()
        service = TextMagicService()
    }
    
    // MARK: - Cursor position tests
    
    /// test that cursor position does not change if state changes but agenda is unchanged
    func testThatCursorPositionDoesNotChangeIfStateChangesButAgendaIsUnchanged() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 11)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 11)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
        
        service.updateText(in: textScreen.textView, newString: TestHelpers.originalText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 11)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor position does not change when agenda has changes after cursor
    func testThatCursorPositionDoesNotChangeWhenAgendaHasChangesAfterCursor() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 11)
        
        let changedText = "Growth and learning"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 11)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor position changes when agenda has removed text before current cursor position
    func testThatCursorPositionChangesWhenAgendaHasRemovedTextBeforeCurrentCursorPosition() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 11)
        
        let changedText = "and learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 4)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor position changes when agenda has changed text before current cursor position
    func testThatCursorPositionChangesWhenAgendaHasChangedTextBeforeCurrentCursorPosition() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 11)
        
        let changedText = "Growing and learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 12)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor position changes when agenda has removed text that includes current cursor position
    func testThatCursorPositionChangesWhenAgendaHasRemovedTextThatIncludesCurrentCursorPosition() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 11)
        
        let changedText = "Growth \n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor position changes when agenda has changed text that includes current cursor position
    func testThatCursorPositionChangesWhenAgendaHasChangedTextThatIncludesCurrentCursorPosition() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 11)
        
        let changedText = "Growth & career development\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 27)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    
    // MARK: - Selected text tests
    
    /// test that text selection does not changes when text does not change
    func testThatTextSelectionDoesNotChangesWhenTextDoesNotChange() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 3)
        
        service.updateText(in: textScreen.textView, newString: TestHelpers.originalText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 3)
    }
    
    /// test that text selection does not change when text changes occur after selection
    func testThatTextSelectionDoesNotChangeWhenTextChangesOccurAfterSelection() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth and learning\n\nWhat are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 3)
    }
    
    /// test that text selection remains same but moves when text is added before selection
    func testThatTextSelectionRemainsSameButMovesWhenTextIsAddedBeforeSelection() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth, development and learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 20)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 3)
    }
    
    /// test that text selection adjusts to include changes that occur within the selection
    func testThatTextSelectionAdjustsToIncludeChangesThatOccurWithinTheSelection() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth ad learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 2)
    }
    
    /// test that text selection expands to include additions that occur within the selection
    func testThatTextSelectionExpandsToIncludeAdditionsThatOccurWithinTheSelection() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth any time we did learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 15)
    }
    
    /// test that text selection is truncated when the end of the selection is removed
    func testThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsRemoved() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth an learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 2)
    }
    
    /// test that text selection is truncated when the end of the selection is changed
    func testThatTextSelectionIsTruncatedWhenTheEndOfTheSelectionIsChanged() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth any learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 2)
    }
    
    /// test that text selection is truncated when the beginning of the selection is removed
    func testThatTextSelectionIsTruncatedWhenTheBeginningOfTheSelectionIsRemoved() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth d learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 1)
    }
    
    /// test that text selection is truncated and moved when the beginning of the selection is changed
    func testThatTextSelectionIsTruncatedAndMovedWhenTheBeginningOfTheSelectionIsChanged() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth that does not end learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 22)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 2)
    }
    
    /// test that cursor does not move when the exact selection is removed
    func testThatCursorDoesNotMoveWhenTheExactSelectionIsRemoved() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 7)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor is moved when entire selection is removed
    func testThatCursorIsMovedWhenEntireSelectionIsRemoved() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growthlearning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 6)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }
    
    /// test that cursor is moved when entire selection is changed
    func testThatCursorIsMovedWhenEntireSelectionIsChanged() {
        textScreen.textView.becomeFirstResponder()
        moveCursorRelativeToBeginning(in: textScreen.textView, offset: 7, length: 3)
        
        let changedText = "Growth or learning\n\nWhat books are you reading?"
        service.updateText(in: textScreen.textView, newString: changedText)
        XCTAssertEqual(cursorOffset(in: textScreen.textView), 9)
        XCTAssertEqual(selectedRangeLength(in: textScreen.textView), 0)
    }

}


// MARK: - Private functions

private extension TextMagicServiceTextViewSpec {
    
    private func cursorOffset(in textInput: UITextInput) -> Int {
        guard let selectedRange = textInput.selectedTextRange else { return 0 }
        return textInput.offsetFromPosition(textInput.beginningOfDocument, toPosition: selectedRange.start)
    }
    
    private func selectedRangeLength(in textInput: UITextInput) -> Int {
        guard let selectedRange = textInput.selectedTextRange else { return 0 }
        return textInput.offsetFromPosition(textInput.beginningOfDocument, toPosition: selectedRange.end) - cursorOffset(in: textInput)
    }
    
    private func moveCursorRelativeToBeginning(in textInput: UITextInput, offset: Int, length: Int = 0) {
        guard let startPosition = textInput.positionFromPosition(textInput.beginningOfDocument, offset: offset), endPosition = textInput.positionFromPosition(startPosition, offset: length) else { return }
        textInput.selectedTextRange = textInput.textRangeFromPosition(startPosition, toPosition: endPosition)
    }

}
