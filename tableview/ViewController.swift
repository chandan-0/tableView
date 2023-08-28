//
// ViewController.swift
// tableview
//
// Created by Chandan-0 on 27/08/23.
// Copyright (c) 2023 Chandan All rights reserved.
//

import UIKit

protocol CellController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

// MARK: - ChandanCellController with CellController
struct ChandanCellController: CellController {
    let data: [String]
    init(data: [String]) {
        self.data = data
    }
    static func regester(_ tableView: UITableView) {
        tableView.register(UINib(nibName: "ChandanCell", bundle: .none), forCellReuseIdentifier: "ChandanCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChandanCell", for: indexPath) as? ChandanCell {
            return  cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Chandan Cell Tapped")
    }
}

// MARK: - PremCellController with CellController
struct PremCellController: CellController {
    let data: [String]
    init(data: [String]) {
        self.data = data
    }
    static func regester(_ tableView: UITableView) {
        tableView.register(UINib(nibName: "PremCell", bundle: .none), forCellReuseIdentifier: "PremCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PremCell", for: indexPath) as? PremCell {
            return  cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("PremCell Tapped")
    }
}

// MARK: - RakshuCellController with CellController
struct RakshuCellController: CellController {
    let data: [String]
    init(data: [String]) {
        self.data = data
    }
    static func regester(_ tableView: UITableView) {
        tableView.register(UINib(nibName: "RakshuCell", bundle: .none), forCellReuseIdentifier: "RakshuCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RakshuCell", for: indexPath) as? RakshuCell {
            return  cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("RakshuCell Tapped")
    }
}


enum CustomSectionType {
    case chandan([String])
    case prem([String])
    case rakshu([String])
}

// MARK: - Main Controllers
class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var cellControllers: [CellController] = []
    
    var section: [CustomSectionType] = [
        .chandan(["chandan", "chandan 2"]),
        .prem(["prem", "prem 2"]),
        .rakshu(["rakshu", "rakshu 2"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        setupTableView(sections: section)
    }

    // MARK: - creating new controller
    func setupTableView(sections: [CustomSectionType]) {
        sections.forEach { sectionType in
            switch sectionType {
            case .chandan(let array):
                ChandanCellController.regester(tableview)
                cellControllers.append(ChandanCellController(data: array))
            case .prem(let array):
                PremCellController.regester(tableview)
                cellControllers.append(PremCellController(data: array))
            case .rakshu(let array):
                RakshuCellController.regester(tableview)
                cellControllers.append(RakshuCellController(data: array))
            }
        }
        tableview.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellControllers[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellControllers[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellControllers[indexPath.section].tableView(tableView, didSelectRowAt: indexPath)
    }
}

