//
//  WordsTableViewController.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit
import SkyengTranslatorFramework

final class WordsTableViewController: UITableViewController {
    private let model: SearchModel
    private let router: MeaningDetailsRouter
    
    init(model: SearchModel, router: MeaningDetailsRouter) {
        self.model = model
        self.router = router
        
        super.init(nibName: nil, bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: MeaningViewCell.nibName, bundle: .main), forCellReuseIdentifier: MeaningViewCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        model.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        model.unsubscribe(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        model.words[section].text
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let id = MeaningId(id: model.words[indexPath.section].meanings[indexPath.row].id)
        router.routeToMeaningDetails(with: id)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        model.words.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.words[section].meanings.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MeaningViewCell else {
            fatalError("Unknown cell type. Expected type \(MeaningViewCell.id)")
        }
        
        let meaning = model.words[indexPath.section].meanings[indexPath.row]
        
        cell.fillIn(with: meaning)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeaningViewCell.id) as? MeaningViewCell else {
            fatalError("Unable to dequeue reusable cell with id \(MeaningViewCell.id)")
        }
        
        return cell
    }
}

extension WordsTableViewController: SearchModelObserver {
    func stateDidChange() {
        switch model.state {
        case .result(_):
            tableView.reloadData()
        default:
            return
        }
    }
}
