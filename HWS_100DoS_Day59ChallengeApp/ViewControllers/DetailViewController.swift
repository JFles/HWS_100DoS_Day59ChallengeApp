//
//  DetailViewController.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/24/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tableView: UITableView!

    var countryFacts = [
        "Capital city: ",
        "Land size: ",
        "Population: ",
        "Currency: ",
        "Interesting facts: "
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureImageView()

        configureTableView()
    }

    fileprivate func configureImageView() {
        imageView.backgroundColor = .lightGray
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
    }

    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - TableView delegate methods
extension DetailViewController: UITableViewDelegate {

}

// MARK: - TableView datasource methods
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryFacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fact", for: indexPath)

        cell.textLabel?.text = countryFacts[indexPath.row]

        return cell
    }
}
