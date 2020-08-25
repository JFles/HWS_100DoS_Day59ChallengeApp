//
//  HomeViewController.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/21/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    // MARK: - Properties
//    var countries = ["Argentina", "United States", "South Korea", "Japan", "Columbia"]

    var countries = [Country]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCountries()

        configureNavigationBar()
    }

    fileprivate func configureNavigationBar() {
        title = "Country facts"

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Networking
    fileprivate func loadCountries() {
        #warning("Wrap this in a dispatchqueue")
        /// https://restcountries.eu/
        let urlString = "https://restcountries.eu/rest/v2/all"
//        let urlString = "https://restcountries.eu/rest/v2/name/afghan"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                print("Failed to retrieve data")
            }
        }
    }

    fileprivate func parse(json: Data) {
        let decoder = JSONDecoder()

        do {
            let jsonCountries = try decoder.decode([Country].self, from: json)
            countries = jsonCountries
            print(countries[35])
        } catch {
            print(error)
        }
    }

}

// MARK: - Tableview methods
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)

        cell.textLabel?.text = countries[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "CountryDetails") as? DetailViewController else { return }

        detailVC.country = countries[indexPath.row]

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

