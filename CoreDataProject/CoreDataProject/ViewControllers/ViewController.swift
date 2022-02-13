//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Данил on 13.02.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var characters = [Person]()
    var fetchRequest: NSFetchRequest<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Helpers
    
    
    
    //MARK: DataLogic
    
    private func importJSONIfNeeded() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let fetchRequest = Person.fetchRequest()
        do {
            let count = try appDelegate.persistentContainer.viewContext.count(for: fetchRequest)
            if (count == 0) {
                writeDataToCoreData()
            }
        } catch {
            print("read data error")
        }
    }
    
    private func writeDataToCoreData() {
        guard let charactersModels = JSONParser.shared.parse()
        else {return}
        for charactersModel in charactersModels {
//            let origin =
        }
    }
    
    
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }


}
