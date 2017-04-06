//
//  ViewController.swift
//  Universities
//
//  Created by Vadim on 4/6/17.
//  Copyright © 2017 Digital Prunes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    var dataSource: UniversitiesDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataSource = UniversitiesDataSource(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editingEnded(_ sender: Any) {
    }

    @IBAction func editingChanged(_ sender: Any) {
        print("entered \(textField.text)")
        dataSource.filterPredicate = NSPredicate(format: "name BEGINSWITH[c] %@", textField.text ?? "")
    }
}

