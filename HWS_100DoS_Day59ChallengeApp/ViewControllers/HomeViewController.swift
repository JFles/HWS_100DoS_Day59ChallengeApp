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
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let strongSelf = self else { return }

            let urlString = "https://restcountries.eu/rest/v2/all"

            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    strongSelf.parse(json: data)
                } else {
                    print("Failed to retrieve data")
                }
            }
        }
    }

    fileprivate func parse(json: Data) {
        let decoder = JSONDecoder()

        do {
            let jsonCountries = try decoder.decode([Country].self, from: json)
            countries = jsonCountries
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
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

