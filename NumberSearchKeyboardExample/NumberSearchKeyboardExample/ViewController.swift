//
//  ViewController.swift
//  NumberSearchKeyboardExample
//
//  Created by Dave Nattrass on 27/10/2017.
//

import UIKit
import NumberSearchKeyboard

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let customDelegate = CustomKeyboardDelegateExample()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Text field example with a custom delegate
        textField.setAsNumericKeyboard(delegate: customDelegate, forSearchBar: nil, includeToolBar: false)
        
       /// Search field example
        self.searchBar.delegate = self
        let searchField = searchBar.value(forKey: "_searchField") as! UITextField
        searchField.setAsNumericKeyboard(delegate: nil, forSearchBar: searchBar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let alertController = UIAlertController(title: "Search", message: "You searched for \(self.searchBar.text)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
