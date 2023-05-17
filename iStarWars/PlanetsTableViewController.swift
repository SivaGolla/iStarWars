//
//  PlanetsTableViewController.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 17/05/23.
//

import UIKit
import CoreData

class PlanetsTableViewController: UITableViewController {

    
//    private var fetchedResultsController: NSFetchedResultsController<Planet>?
    private var planets: [Planet] = []
    private lazy var planetService: PlanetService = {
        return PlanetService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        fetchPlanets()
    }

    private func fetchPlanets() {
        LoadingView.start()
        
        let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        planets = planetService.fetchAllPlanets(sortDescriptors: sortDescriptors)
        
        if !planets.isEmpty {
            tableView.reloadData()
            LoadingView.stop()
            return
        }
        
        loadRemotePlanets()
    }
    
    private func loadRemotePlanets() {
        
        let serviceRequest = ServiceRequestFactory.createPlanets()
        serviceRequest.fetch { [weak self] (result: Result<PlanetsResponseModel, NetworkError>) in
        
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    
                case .success(_):
                    let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                    if let planets = self?.planetService.fetchAllPlanets(sortDescriptors: sortDescriptors) {
                        self?.planets = planets
                    }
                    self?.tableView.reloadData()
                }
                
                LoadingView.stop()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return planets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetTableViewCell

        let planet = planets[indexPath.row]
        cell.nameLabel.text = planet.name

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
