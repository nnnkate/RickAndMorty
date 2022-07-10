//
//  StatusLabel.swift
//  RickAndMorty
//
//  Created by Ekaterina Nedelko on 10.07.22.
//

import UIKit

class StatusLabel: UILabel {
    
    // MARK: - Initialization and deinitialization
    
    init(status: CharacterStatus = .unknown) {
        super.init(frame: .zero)
        
        self.setupAppearance()
        self.configureAttributedLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance methods

private extension StatusLabel {
    func setupAppearance() {
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
        font = UIFont(name: "TrebuchetMS", size: CGFloat(20).adaptedFontSize)
        textColor = .white
    }
}

// MARK: - Public methods

extension StatusLabel {
    func configureAttributedLabel(status: CharacterStatus = .unknown, species: String = "") {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "circle.fill")?.withTintColor(status.statusColor)
        attachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let strLabelText = NSAttributedString(string: " \(status.rawValue) - \(species)")
        
        let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
        mutableAttachmentString.append(strLabelText)
        
        self.attributedText = mutableAttachmentString
    }
}


