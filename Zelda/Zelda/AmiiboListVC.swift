//
//  ViewController.swift
//  Zelda
//
//  Created by Aksel Kantar on 30/03/2019.
//  Copyright © 2019 Aksel Kantar. All rights reserved.
//

import UIKit

class AmiiboListVC: UIViewController {

    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var amiiboList = [AmiiboForView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()

        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in

            DispatchQueue.main.async {
                let amiiboForViewList = fetchedAmiiboList.map { amiibo in
                    return AmiiboForView(name: amiibo.name, gameSeries: amiibo.gameSeries, imageUrl: amiibo.image)
                }
                self.amiiboList = amiiboForViewList
                self.tableView.reloadData()
            }

        }
        AmiiboAPI.shared.fetchAmiiboList(onCompletion: anonymousFunction)

    }

    func setupTableView(){

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cell")
    }

}

//MARK: - TableView Methods

extension AmiiboListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("array items achieved")
        return amiiboList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let amiibo = amiiboList[indexPath.row]
        
        guard let amiiboCell = cell as? AmiiboCell else {
            return cell
        }
        amiiboCell.nameLabel.text = amiibo.name
        amiiboCell.gameSeriesLabel.text = amiibo.gameSeries
        if let url = URL(string: amiibo.imageUrl) {
            amiiboCell.imageIV.loadImage(from: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let amiibo = amiiboList[indexPath.row]
        let amiiboDetailVC = AmiiboDetailVC()
        amiiboDetailVC.amiiboForDetailVC = amiibo
        self.present(amiiboDetailVC, animated: true, completion: nil)
    }
    
    
}
