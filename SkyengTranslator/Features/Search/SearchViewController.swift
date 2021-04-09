//
//  SearchViewController.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 07.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit
import SkyengTranslatorFramework

final class SearchViewController: UIViewController, UITextFieldDelegate, SearchModelObserver {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var resultsTablePlaceholder: UIStackView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var messageView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var resultsTableViewController: UITableViewController = {
        let router = DefaultMeaningDetailsRouter(navigationController: navigationController!)
        return WordsTableViewController(model: model, router: router)
    }()
    
    private let model: SearchModel
    
    init(model: SearchModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        
        resultsTablePlaceholder.addArrangedSubview(resultsTableViewController.view)
        addChild(resultsTableViewController)
        resultsTableViewController.didMove(toParent: self)
        
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        model.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        model.unsubscribe(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text else {
            return false
        }
        
        model.search(string: text)
        
        return true
    }
    
    func stateDidChange() {
        switch model.state {
        case .initial:
            resultsTablePlaceholder.isHidden = true
            messageView.isHidden = false
            messageLabel.text = "Search results will be diplayed here"
            activityIndicator.stopAnimating()
        case .loading:
            resultsTablePlaceholder.isHidden = true
            messageView.isHidden = true
            messageLabel.text = ""
            activityIndicator.startAnimating()
        case .emptyResult:
            resultsTablePlaceholder.isHidden = true
            messageView.isHidden = false
            messageLabel.text = "No data found"
            activityIndicator.stopAnimating()
        case .result(_):
            resultsTablePlaceholder.isHidden = false
            messageView.isHidden = true
            activityIndicator.stopAnimating()
        case .error(_):
            // show popup
            break
        }
    }
}
