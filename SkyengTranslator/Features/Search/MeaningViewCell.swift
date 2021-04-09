//
//  MeaningViewCell.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit
import SkyengTranslatorFramework

final class MeaningViewCell: UITableViewCell {

    static let nibName = "MeaningViewCell"
    static let id = "MeaningViewCell"
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func fillIn(with meaning: Meaning) {
        headerLabel.text = meaning.translation.text
        descriptionLabel.text = String(format: "%@ / %@ / %@", meaning.partOfSpeechCode.description, meaning.transcription, meaning.translation.note ?? "")
    }
    
}
