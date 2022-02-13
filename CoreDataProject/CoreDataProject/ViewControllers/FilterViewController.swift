//
//  FilterViewController.swift
//  CoreDataProject
//
//  Created by Данил on 13.02.2022.
//

import UIKit
import CoreData

protocol FilterViewControllerDelegate: class {
    func filterViewController(filter: FilterViewController, predicate: NSPredicate?, sort: NSSortDescriptor?)
}

class FilterViewController: UITableViewController {

    weak var delegate: FilterViewControllerDelegate?
    var selectedSortDescriptor: NSSortDescriptor?
    var selectedPredicate: NSPredicate?
    weak var appDelegate = (UIApplication.shared.delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillAllLabels()

    }
    
    //MARK: UIActions

    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchAction(_ sender: Any) {
        delegate?.filterViewController(filter: self, predicate: selectedPredicate, sort: selectedSortDescriptor)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Predicates
    
    lazy var maleGenderPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Person.gender), "Male")
    }()
    
    lazy var femaleGenderPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Person.gender), "Female")
    }()
    
    lazy var undefinedGenderPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Person.gender), "undefined")
    }()
    
    lazy var earthOriginPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Person.origin.name), "Earth")
    }()
    
    lazy var moonOriginPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Person.origin.name), "Moon")
    }()
    
    lazy var undefinedOriginPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(Person.origin.name), "undefined")
    }()
    
    //MARK: SortDescriptors
    
    lazy var nameSort: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Person.name), ascending: true)
    }()
    
    lazy var idSort: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Person.iD), ascending: true)
    }()
    
    lazy var episodesSort: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Person.episodes), ascending: true)
    }()
    
    
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
//MARK: UITableViewDelegate
extension FilterViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        switch cell {
        case maleCell:
            print("male")
            selectedPredicate = maleGenderPredicate
        case femaleCell:
            selectedPredicate = femaleGenderPredicate
        case undefinedGenderCell:
            selectedPredicate = undefinedGenderPredicate
        case earthCell:
            selectedPredicate = earthOriginPredicate
        case moonCell:
            selectedPredicate = moonOriginPredicate
        case undefinedOriginCell:
            selectedPredicate = undefinedOriginPredicate
        case SortByEpisodes:
            selectedSortDescriptor = episodesSort
        case sortByIDCell:
            selectedSortDescriptor = idSort
        case sortByNameCell:
            selectedSortDescriptor = nameSort
        default:
            selectedPredicate = nil
        }
        cell.accessoryType = .checkmark
    }
}
//MARK: Наполнение надписей с количеством
extension FilterViewController {
    
    private func fillAllLabels() {
        fillLabelWithPredicate(label: maleCountLabel, predicate: maleGenderPredicate)
        fillLabelWithPredicate(label: famaleCountLabel, predicate: femaleGenderPredicate)
        fillLabelWithPredicate(label: undefinedGenderCountLabel, predicate: undefinedGenderPredicate)
        fillLabelWithPredicate(label: earthCountLabel, predicate: earthOriginPredicate)
        fillLabelWithPredicate(label: moonCountLabel, predicate: moonOriginPredicate)
        fillLabelWithPredicate(label: undefinedOriginCountLabel, predicate: undefinedOriginPredicate)
    }
    
    private func fillLabelWithPredicate(label: UILabel, predicate: NSPredicate) {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            let count = try appDelegate?.persistentContainer.viewContext.count(for: fetchRequest) ?? 0
            label.text = "\(count) characters"
        } catch {
            print("fill error")
        }
    }
}
