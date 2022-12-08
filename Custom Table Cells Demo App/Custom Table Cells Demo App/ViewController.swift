//
//  ViewController.swift
//  Custom Table Cells Demo App
//
//  Created by laptop on 2022-10-10.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Calling cellForRowAtIndexPath for row: \(indexPath.row)")
        
        //Instantiate new Table View Cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        
        //set the contents
        myCell.textLabel?.text = "This is row number \(indexPath.row)"
        myCell.imageView?.image = UIImage(named: "clock")
        myCell.accessoryType = .disclosureIndicator
        myCell.detailTextLabel?.text = "This is some detail text"
        
        return myCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

