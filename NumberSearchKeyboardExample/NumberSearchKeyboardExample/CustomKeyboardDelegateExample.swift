//
//  CustomKeyboardDelegateExample.swift
//  NumberSearchKeyboardExample
//
//  Created by Dave Nattrass on 30/10/2017.
//  Copyright © 2017 Cobalt Telephone Technologies. All rights reserved.
//

import UIKit
import NumberSearchKeyboard

class CustomKeyboardDelegateExample: NumberSearchKeyboardDelegate {
    
    func numericKeyPressed(key: Int) {
        let alertController = UIAlertController(title: "Custom Delegate", message: "Custom delegate number key \(key) was tapped", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func backspacePressed() {
        let alertController = UIAlertController(title: "Custom Delegate", message: "Custom delegate backspace key was tapped", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func backspaceHeld() {
        let alertController = UIAlertController(title: "Custom Delegate", message: "Custom delegate backspace key was held", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func searchPressed() {
        let alertController = UIAlertController(title: "Custom Delegate", message: "You triggered a custom delegate search function", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func changeKeyboardPressed() {
        let alertController = UIAlertController(title: "Custom Delegate", message: "You triggered a custom delegate change keyboard function", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
