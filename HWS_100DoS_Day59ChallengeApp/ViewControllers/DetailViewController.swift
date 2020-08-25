//
//  DetailViewController.swift
//  HWS_100DoS_Day59ChallengeApp
//
//  Created by Jeremy Fleshman on 8/24/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder

class DetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tableView: UITableView!

    var country: Country?

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

        configureNavigationBar()
        configureImageView()
        configureTableView()
    }

    fileprivate func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = country?.name
    }

    fileprivate func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        loadImage()
        imageView.layer.borderWidth = 0.25
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    fileprivate func loadImage() {
        guard let url = URL(string: country?.flagUrl ?? "") else { return }

        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        imageView.sd_setImage(with: url) { [weak self] _,_,_,_ in
            guard let strongSelf = self else { return }

            let imageHeight = strongSelf.imageView.image?.size.height ?? 0
            let imageWidth = strongSelf.imageView.image?.size.width ?? 0
            let screenWidth = UIScreen.main.bounds.width
            let scaledHeight = screenWidth * (imageHeight / imageWidth)

            strongSelf.imageView.heightAnchor.constraint(equalToConstant: scaledHeight).isActive = true
        }
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
