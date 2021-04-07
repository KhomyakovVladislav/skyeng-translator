//
//  SearchViewController.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 07.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    private lazy var router: MeaningRouter? = {
        guard let navigationController = navigationController else {
            return nil
        }
        
        return DefaultMeaningRouter(navigationController: navigationController)
    }()
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchService().doRequest(SearchRequest(search: "test", page: nil, pageSize: nil)) { response, error in
            print(response ?? "no data")
        }
    }

    @IBAction private func onTap() {
        router?.routeToMeaning(id: 0)
    }
}
