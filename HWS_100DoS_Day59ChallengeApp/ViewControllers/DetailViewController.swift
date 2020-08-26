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
    var countryData = [Fact]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureImageView()
        configureTableView()
        createFactData()
    }

    fileprivate func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
//        title = country?.name
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

    fileprivate func createFactData() {
        #warning("refactor this -- possibly generate flattened object from JSONDecoder on network call parse")
        guard let country = country else { return }

        for key in DefinedFacts.allCases {
            let fact: Fact

            switch key {
            case .name:
                fact = Fact(name: "Country", data: country.name as String)
            case .capital:
                fact = Fact(name: "Capital", data: country.capital as String)
            case .population:
                fact = Fact(name: "Population", data: country.population as Int)
            case .demonym:
                fact = Fact(name: "Demonym", data: country.demonym as String)
            case .area:
                fact = Fact(name: "Area", data: country.area as Double)
            case .timezones:
                #warning("Add a loop structure")
                fact = Fact(name: "Timezone", data: country.timezones.first ?? "")
            case .currencyCode:
                #warning("Add a loop structure")
                fact = Fact(name: "Currency Code", data: country.currencies.first?.code ?? "")
            case .currencyName:
                #warning("Add a loop structure")
                fact = Fact(name: "Currency Name", data: country.currencies.first?.name ?? "")
            case .currencySymbol:
                #warning("Add a loop structure")
                fact = Fact(name: "Currency Symbol", data: country.currencies.first?.symbol ?? "")
            case .languageName:
                #warning("Add a loop structure")
                fact = Fact(name: "Language", data: country.languages.first?.name ?? "")
            }

            countryData.append(fact)
        }
    }
}

// MARK: - TableView delegate methods
extension DetailViewController: UITableViewDelegate {

}

// MARK: - TableView datasource methods
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fact", for: indexPath)

        let fact = countryData[indexPath.row]

        cell.textLabel?.text = "\(fact.name)"
        cell.detailTextLabel?.text = "\(fact.data)"

        return cell
    }
}
