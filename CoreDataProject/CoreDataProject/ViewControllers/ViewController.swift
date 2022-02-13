//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Данил on 13.02.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = [Person]()
    var fetchRequest: NSFetchRequest<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        importJSONIfNeeded()
        fetchRequest = Person.fetchRequest()
        fetchAndReload()
    }
    
//    MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController,
              let vc = nc.viewControllers.first as? FilterViewController
        else {return}
        vc.delegate = self
    }
    
    //MARK: Helpers
    
    
    
    //MARK: DataLogic
    
    private func importJSONIfNeeded() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let count = try appDelegate.persistentContainer.viewContext.count(for: fetchRequest)
            print("hello")
            if (count == 0) {
                writeDataToCoreData()
            }
        } catch {
            print("read data error")
        }
    }
    
    private func writeDataToCoreData() {
        print("writeData")
        guard let charactersModels = JSONParser.shared.parse(),
              let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else {return}
        for charactersModel in charactersModels {
            print(charactersModel)
            let origin = Location(context: context)
            origin.name = charactersModel.origin.name

            let person = Person(context: context)
            person.origin = origin

            person.name = charactersModel.name
            person.episodes = Int16(charactersModel.episode.count)
            person.gender = charactersModel.gender
            person.iD = Int16(charactersModel.iD)
            person.image = charactersModel.image
            person.status = charactersModel.status
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    private func fetchAndReload() {
        guard let fetchRequest = fetchRequest,
              let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else {
            return
        }
    
        do {
            characters = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Could not fetch \(error.localizedDescription)")
        }
    }
    
    
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        cell.detailTextLabel?.text = characters[indexPath.row].origin?.name
        return cell
    }


}

extension ViewController: FilterViewControllerDelegate {
    func filterViewController(filter: FilterViewController, predicate: NSPredicate?, sort: NSSortDescriptor?) {
        guard let fetchRequest = fetchRequest else {return}
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = nil
        fetchRequest.predicate = predicate
        if let sort = sort {
            fetchRequest.sortDescriptors = [sort]
        }
        fetchAndReload()
    }
}
