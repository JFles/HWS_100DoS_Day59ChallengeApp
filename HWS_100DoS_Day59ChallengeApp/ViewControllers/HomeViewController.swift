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
    var countries = ["Argentina", "United States", "South Korea", "Japan", "Columbia"]


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        #warning("refactor")
        countries.sort()

        configureNavigationBar()
    }

    fileprivate func configureNavigationBar() {
        title = "Country facts"

        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - Tableview methods
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)

        cell.textLabel?.text = countries[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #warning("Implement")

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "CountryDetails") else { return }

        // set data here

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

