//
//  MeaningViewController.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit
import SkyengTranslatorFramework

final class MeaningViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
     
        return imageView
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(imageView)
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 16.0)
        label.textColor = .lightGray
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        return stackView
    }()
    
    private lazy var examplesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        
        return stackView
    }()
    
    private lazy var examplesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Examples:"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .whiteLarge
        view.color = .gray
        view.hidesWhenStopped = true
        
        return view
    }()
    
    private lazy var swipeGestureRecognizer: UIGestureRecognizer = {
        let gr = UISwipeGestureRecognizer()
        gr.direction = .right
        gr.addTarget(self, action: #selector(onSwipe))
        gr.numberOfTouchesRequired = 1
        
        return gr
    }()
    
    private var imageStackViewTopConstraint: NSLayoutConstraint?
    private var titleStackViewTopConstraint: NSLayoutConstraint?
    
    private let model: MeaningDetailsModel

    init(model: MeaningDetailsModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: .main)
        
        model.subscribe(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        view.addSubview(imageStackView)
        view.addSubview(titleStackView)
        view.addSubview(examplesTitleLabel)
        view.addSubview(examplesStackView)
        
        imageStackViewTopConstraint = imageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: -Constants.imageHeight)
        titleStackViewTopConstraint = titleStackView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: -20.0)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.imageHeight / 2),
            
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            imageStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageStackViewTopConstraint!,
            
            titleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            titleStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            titleStackViewTopConstraint!,
            
            examplesTitleLabel.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            examplesTitleLabel.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            examplesTitleLabel.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20.0),
            
            examplesStackView.leadingAnchor.constraint(equalTo: examplesTitleLabel.leadingAnchor, constant: 16.0),
            examplesStackView.trailingAnchor.constraint(equalTo: examplesTitleLabel.trailingAnchor),
            examplesStackView.topAnchor.constraint(equalTo: examplesTitleLabel.bottomAnchor, constant: 20.0)
        ])
        
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        self.view = view
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        model.unsubscribe(self)
    }
    
    @objc
    private func onSwipe() {
        navigationController?.popViewController(animated: true)
    }
}

extension MeaningViewController: MeaningDetailsModelObserver {
    func stateDidChange() {
        switch model.state {
        case .result(let meaning, let imageData):
            activityIndicator.stopAnimating()
            
            if let imageData = imageData {
                imageView.image = UIImage(data: imageData)
                UIView.animate(withDuration: CATransaction.animationDuration()) {
                    self.imageStackViewTopConstraint?.constant = 0
                    self.titleStackViewTopConstraint?.constant = Constants.imageHeight - self.view.safeAreaInsets.top + 20.0
                    
                    self.view.layoutIfNeeded()
                }
            }
            
            titleLabel.text = String(
                format: "%@ %@",
                meaning.prefix ?? "",
                meaning.text
            ).trimmingCharacters(in: CharacterSet(charactersIn: " "))
            
            subtitleLabel.text = String(
                format: "%@ / %@ / %@",
                meaning.partOfSpeechCode.description,
                meaning.transcription,
                meaning.translation.text
            )
            
            examplesTitleLabel.isHidden = meaning.examples.isEmpty
            
            examplesStackView.subviews.forEach {
                examplesStackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            
            meaning.examples.prefix(5).forEach {
                let label = UILabel()
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.text = $0.text
                label.font = .italicSystemFont(ofSize: 16.0)
                label.textColor = .gray
                label.translatesAutoresizingMaskIntoConstraints = false

                examplesStackView.addArrangedSubview(label)
            }
        case .loading:
            activityIndicator.startAnimating()
            break
        case .noData:
            break
        case .error(_):
            break
        }
    }
    
    private enum Constants {
        static let imageHeight: CGFloat = 250.0
    }
}
