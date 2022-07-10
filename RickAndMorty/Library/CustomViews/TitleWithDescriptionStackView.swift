//
//  TitleWithDescriptionStackView.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import Foundation
import UIKit

class TitleWithDescriptionStackView: UIStackView {
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont(name: "TrebuchetMS", size: CGFloat(20).adaptedFontSize)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 1
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont(name: "TrebuchetMS", size: CGFloat(20).adaptedFontSize)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        
        return descriptionLabel
    }()
    
    // MARK: - Initialization and deinitialization
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.setupAppearance(title: title)
        self.addSubviews()
        self.configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance methods

private extension TitleWithDescriptionStackView {
    func setupAppearance(title: String) {
        self.axis = .vertical
        self.distribution = .fillEqually
        //self.spacing = 2.VAdapted
        
        titleLabel.text = title
    }
    
    func addSubviews() {
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(descriptionLabel)
    }
    
    func configureLayout() {
        
    }
}

// MARK: - Public methods

extension TitleWithDescriptionStackView {
    func configure(with description: String) {
        descriptionLabel.text = description
    }
}

