//
//  ResultViewController.swift
//  FoodyCat
//
//  Created by Essam Orabi on 23/01/2022.
//

import UIKit
import CoreLocation

protocol ResultViewControllerDelegate: AnyObject {
    func didTapPlace(with coordinates: CLLocationCoordinate2D)
}

class ResultViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        return table
    }()
    weak var delegate: ResultViewControllerDelegate?
    private var places: [Place] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    public func update(with places: [Place]) {
        tableView.isHidden = false
        self.places = places
        tableView.reloadData()
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        let place = places[indexPath.row]
        GooglePlacesManager.shared.resolveLocation(for: place) { result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    self.delegate?.didTapPlace(with: coordinate)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
