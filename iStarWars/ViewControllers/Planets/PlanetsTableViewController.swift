//
//  PlanetsTableViewController.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 17/05/23.
//

import UIKit
import CoreData

/// Presents a list of Planets from Star Wars
class PlanetsTableViewController: UITableViewController {

    
//    private var fetchedResultsController: NSFetchedResultsController<Planet>?
    private var datasource = PlanetsDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityIdentifier = "homeView"
        title = "Star Wars - Planets"
        tableView.rowHeight = 70
        fetchPlanets()
    }

    private func fetchPlanets() {
        LoadingView.start()
        
        datasource.fetchPlanets()
        
        if !datasource.planets.isEmpty {
            tableView.reloadData()
            LoadingView.stop()
            return
        }
        
        datasource.loadRemotePlanets { [weak self] success in
            
            if !success {
                if let alert = self?.okAlertPrompt(title: "Star Wars - Planets", message: "Failed to load Planets") {
                    self?.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            self?.datasource.fetchPlanets()
            self?.tableView.reloadData()
            LoadingView.stop()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.planets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetTableViewCell

        let planet = datasource.planets[indexPath.row]
        cell.configure(name: planet.name, population: planet.population)

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
