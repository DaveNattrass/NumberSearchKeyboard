//
//  UITextField+NumberSearchKeyboard.swift
//  NumberSearchKeyboard
//
//  Created by Dave Nattrass on 26/10/2017.
//

import UIKit

public var numberSearchKeyboardDelegate: NumberSearchKeyboardDelegate? = nil
public var searchBar: UISearchBar? = nil
public var includeToolbar = true

extension UITextField: NumberSearchKeyboardDelegate {
    
    /// Set the input view of a textfield as a number search keyboard
    ///
    /// - Parameters:
    ///   - delegate: Can override the default key functions with a different delegate if you wish
    ///   - forSearchBar: The search bar that the textfield belongs to (if you are using it on a search bar, which you probably are).  Ensures the search key triggers the search bar's search function
    ///   - includeToolbar: Adds a floating toolbar above the keyboard which includes a cancel button.  If user changes to a standard keyboard it also includes a button to get back to the Numeric Keyboard
    public func setAsNumericKeyboard(delegate: NumberSearchKeyboardDelegate? = nil, forSearchBar search: UISearchBar? = nil, includeToolBar toolbar: Bool = true) {
        
        let numericKeyboard = NumberSearchKeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: 216))
        numberSearchKeyboardDelegate = delegate
        numericKeyboard.delegate = numberSearchKeyboardDelegate ?? self
        self.inputView = numericKeyboard
        
        includeToolbar = toolbar
        if includeToolbar {
            self.addNumberSearchToolbar()
        }
        
        if search != nil {
            searchBar = search
        }
        
    }
    
    /// Reset the input view of the textfield back to it's standard one.
    public func unsetAsNumericKeyboard() {
        if let numericKeyboard = self.inputView as? NumberSearchKeyboardView {
            numericKeyboard.delegate = nil
        }
        self.inputView = nil
        numberSearchKeyboardDelegate = nil
    }
    
    // MARK:- Delegate functions
    
    /// Press a number key, get a number in your text field
    /// - Paramter: key: the number that was pressed.
    public func numericKeyPressed(key: Int) {
        self.text?.append("\(key)")
        numberSearchKeyboardDelegate?.numericKeyPressed(key: key)
    }
    
    /// Press the backspace key, remove the last entered number
    public func backspacePressed() {
        if var text = self.text, text.characters.count > 0 {
            _ = text.remove(at: text.index(before: text.endIndex))
            self.text = text
        }
        numberSearchKeyboardDelegate?.backspacePressed()
    }
    
    /// Hold down the backspace key, remove everything
    public func backspaceHeld() {
        self.text = ""
        numberSearchKeyboardDelegate?.backspaceHeld()
    }
    
    /// Press the search key, tell the search bar's delegate to execute a search
    public func searchPressed() {
        guard let searchBar = searchBar else {
            return
        }
        searchBar.delegate?.searchBarSearchButtonClicked!(searchBar)
    }
    
    /// Press the change keyboard key, change to a standard keyboard view
    public func changeKeyboardPressed() {
        self.inputView = nil
        self.keyboardType = .default
        
        if includeToolbar {
            self.addNumberSearchToolbar(showSwapper: true)
        }
        
        self.reloadInputViews()
        
        // If the user closes the input views and then taps the textfield again we want it to default to our numeric keyboard so set it up again in preperation.
        self.setAsNumericKeyboard(delegate: numberSearchKeyboardDelegate, forSearchBar: searchBar, includeToolBar: includeToolbar)
        numberSearchKeyboardDelegate?.changeKeyboardPressed()
    }
    
    // MARK: Tool bar functions
    
    /// Adds a tool bar above the input view, always includes a cancel button to dismiss the keyboard
    /// Parameter: showSwapper: should we include a button to allow to swap back to the Number Search keyboard?
    public func addNumberSearchToolbar(showSwapper swapper: Bool = false) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let numberSearchKeyboardButton = UIBarButtonItem(title: "123", style: .plain, target: self, action: #selector(self.changeToNumSearchKeyboard))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.toolBarCancelClick))
        
        if swapper {
            // Should include a button to change input view back to the number search keyboard
            toolBar.setItems([numberSearchKeyboardButton, spacer, cancelButton], animated: false)
        } else {
            toolBar.setItems([spacer, spacer, cancelButton], animated: false)
        }
        self.inputAccessoryView = toolBar
    }
    
    /// Changes the input view to the number search keyboard
    @objc private func changeToNumSearchKeyboard() {
        self.setAsNumericKeyboard(delegate: numberSearchKeyboardDelegate, forSearchBar: searchBar, includeToolBar: includeToolbar)
        self.reloadInputViews()
    }
    
    /// Closes the currently active inputview.
    @objc private func toolBarCancelClick() {
        self.resignFirstResponder()
    }
    
    
}
