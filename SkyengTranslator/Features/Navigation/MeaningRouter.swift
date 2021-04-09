//
//  MeaningRouter.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit
import SkyengTranslatorFramework

protocol MeaningDetailsRouter {
    func routeToMeaningDetails(with id: MeaningId)
}

final class DefaultMeaningDetailsRouter: MeaningDetailsRouter {
    
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToMeaningDetails(with id: MeaningId) {
        let model = MeaningDetailsModel(
            meaningId: id,
            meaningDetailsService: MeaningDetailsService(),
            imageService: ImageService()
        )
        let vc = MeaningViewController(model: model)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
