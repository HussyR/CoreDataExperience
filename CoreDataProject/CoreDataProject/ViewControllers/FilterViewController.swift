//
//  FilterViewController.swift
//  CoreDataProject
//
//  Created by Данил on 13.02.2022.
//

import UIKit

class FilterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: UIActions

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UIElements
    @IBOutlet weak var maleCountLabel: UILabel!
    @IBOutlet weak var famaleCountLabel: UILabel!
    @IBOutlet weak var undefinedGenderCountLabel: UILabel!
    
    @IBOutlet weak var earthCountLabel: UILabel!
    @IBOutlet weak var moonCountLabel: UILabel!
    @IBOutlet weak var undefinedOriginCountLabel: UILabel!
    
    @IBOutlet weak var SortByEpisodes: UITableViewCell!
    @IBOutlet weak var sortByIDCell: UITableViewCell!
    @IBOutlet weak var sortByNameCell: UITableViewCell!
    
    @IBOutlet weak var earthCell: UITableViewCell!
    @IBOutlet weak var undefinedOriginCell: UITableViewCell!
    @IBOutlet weak var moonCell: UITableViewCell!
    
    @IBOutlet weak var maleCell: UITableViewCell!
    @IBOutlet weak var undefinedGenderCell: UITableViewCell!
    @IBOutlet weak var femaleCell: UITableViewCell!
}
