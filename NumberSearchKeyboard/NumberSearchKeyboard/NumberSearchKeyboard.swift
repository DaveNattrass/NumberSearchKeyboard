//
//  NumberSearchKeyboard.swift
//  NumberSearchKeyboard
//
//  Created by Dave Nattrass on 25/10/2017.
//

import UIKit

struct NumberSearchKeyboardConstants {
    static let xibName = "NumberSearchKeyboard"
}

@objc public protocol NumberSearchKeyboardDelegate {
    func numericKeyPressed(key: Int)
    func backspacePressed()
    func backspaceHeld()
    func searchPressed()
    func changeKeyboardPressed()
}

class NumberSearchKeyboardView: UIView {
    
    @IBOutlet weak var buttonOne: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonTwo: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonThree: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonFour: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonFive: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonSix: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonSeven: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonEight: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonNine: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonZero: NumberSearchKeyboardButton!
    
    @IBOutlet weak var buttonBackspace: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonKeyboardChange: NumberSearchKeyboardButton!
    @IBOutlet weak var buttonSearch: NumberSearchKeyboardButton!
    
    weak var delegate: NumberSearchKeyboardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initalizeKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initalizeKeyboard()
    }
    
    /// Initalize the keyboard view
    func initalizeKeyboard() {
        let view = Bundle(for: self.classForCoder).loadNibNamed(NumberSearchKeyboardConstants.xibName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        self.backgroundColor = UIColor.init(red: 0.784, green: 0.796, blue: 0.827, alpha: 1)
        
        // Set delete button gestures, seems if you add a long tap you also have to add a short one.
        let shortTap = UITapGestureRecognizer(target: self, action: #selector(self.backspacePressed))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.backspaceHeld))
        self.buttonBackspace.addGestureRecognizer(shortTap)
        self.buttonBackspace.addGestureRecognizer(longTap)
    }

    // MARK:- Button Actions
    @IBAction func numericButtonPressed(_ sender: UIButton) {
        self.delegate?.numericKeyPressed(key: sender.tag)
    }
    
    @objc @IBAction func backspacePressed(_ sender: AnyObject) {
        self.delegate?.backspacePressed()
    }
    
    @objc func backspaceHeld() {
        self.delegate?.backspaceHeld()
    }
    
    @IBAction func searchPressed(_ sender: AnyObject) {
        self.delegate?.searchPressed()
    }
    
    @IBAction func changeKeyboardPressed(_ sender: AnyObject) {
        self.delegate?.changeKeyboardPressed()
    }
    
}
