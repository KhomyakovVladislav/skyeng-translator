//
//  WordsTableViewController.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit

final class WordsTableViewController: UITableViewController {
    private let model: SearchModel
    private let router: MeaningRouter
    
    init(model: SearchModel, router: MeaningRouter) {
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
        guard let words = model.words else {
            return nil
        }
        
        return words[section].text
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let words = model.words else {
            return
        }
        
        router.routeToMeaning(id: words[indexPath.section].meanings[indexPath.row].id)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let words = model.words else {
            return 0
        }
        
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let words = model.words else {
            return 0
        }
        
        return words[section].meanings.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeaningViewCell.id) as? MeaningViewCell else {
            fatalError("Unable to dequeue reusable cell with id \(MeaningViewCell.id)")
        }
        
        guard let words = model.words else {
            return cell
        }
        
        let meaning = words[indexPath.section].meanings[indexPath.row]
        
        cell.fillIn(with: meaning)
        
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
