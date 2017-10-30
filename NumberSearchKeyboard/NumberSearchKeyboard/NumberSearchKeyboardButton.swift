//
//  NumberSearchKeyboardButton.swift
//  NumberSearchKeyboard
//
//  Created by Dave Nattrass on 26/10/2017.
//

import UIKit

/// Buttons on the xib have two purposes:
/// Tag on standard keys (0...9) are the value of the key
/// 11,12 and 13 relate to function keys (delete, search and change keyboard respectively)
enum NumberSearchKeyboardButtonFunction: Int {
    case standardKey = 0
    case deleteKey = 11
    case searchKey = 12
    case changeKeyboardKey = 13
}

class NumberSearchKeyboardButton: UIButton {
    
    var buttonFunction: NumberSearchKeyboardButtonFunction = .standardKey
    
    var _normalBackgroundColor: UIColor = UIColor.white
    var normalBackgroundColor: UIColor {
        get { return _normalBackgroundColor }
        set {
            _normalBackgroundColor = newValue
            self.backgroundColor = _normalBackgroundColor
        }
    }
    
    var highlightedBackgroundColor: UIColor = UIColor.lightGray
    
    override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            if newValue {
                backgroundColor = self.highlightedBackgroundColor
            } else {
                backgroundColor = self.normalBackgroundColor
            }
            super.isHighlighted = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buttonFunction = NumberSearchKeyboardButtonFunction(rawValue: self.tag) ?? .standardKey
        self.styleButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buttonFunction = NumberSearchKeyboardButtonFunction(rawValue: self.tag) ?? .standardKey
        self.styleButton()
    }
    
    /// Styles the button to have the appropiate apperance settings
    private func styleButton() {
        // Standard Styling
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        // Function specific styling
        switch self.buttonFunction {
            case .searchKey:
                // Blue key that goes white on highlight
                self.setTitleColor(UIColor.white, for: .normal)
                self.setTitleColor(UIColor.black, for: .highlighted)
                self.normalBackgroundColor = UIColor.init(red:0, green: 0.435, blue: 1, alpha: 1)
                self.highlightedBackgroundColor = UIColor.white
            case .deleteKey, .changeKeyboardKey:
                // Gray key that goes white on highlight
                self.setTitleColor(UIColor.black, for: .normal)
                self.setTitleColor(UIColor.white, for: .highlighted)
                self.normalBackgroundColor = UIColor.init(red: 0.647, green: 0.667, blue: 0.714, alpha: 1)
                self.highlightedBackgroundColor = UIColor.white
            default:
                // White key that goes gray on highlight
                self.setTitleColor(UIColor.black, for: .normal)
                self.setTitleColor(UIColor.white, for: .highlighted)
                self.backgroundColor = UIColor.white
                self.highlightedBackgroundColor = UIColor.init(red: 0.647, green: 0.667, blue: 0.714, alpha: 1)
        }
        
    }
    
    /// Haptic & sound feedback for key taps
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        UIDevice.current.playInputClick()
        super.touchesBegan(touches, with: event)
    }
    
}
