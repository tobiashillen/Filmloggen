//
//  ViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-07.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search"{
            let searchResultVC : SearchResultTableViewController = segue.destination as! SearchResultTableViewController
            if let searchWord = searchTextField.text {
                searchResultVC.searchWord = searchWord
            }
        }
    }
}

