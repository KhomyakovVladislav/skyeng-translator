//
//  MeaningRouter.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit

protocol MeaningRouter {
    func routeToMeaning(id: Int)
}

final class DefaultMeaningRouter: MeaningRouter {
    
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToMeaning(id: Int) {
        let model = MeaningDetailsModel(
            meaningId: id,
            meaningDetailsService: MeaningDetailsService(),
            imageService: ImageService()
        )
        let vc = MeaningViewController(model: model)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
