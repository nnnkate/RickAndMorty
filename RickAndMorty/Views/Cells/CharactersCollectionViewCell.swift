//
//  CharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Екатерина Неделько on 23.06.22.
//

import UIKit
import SnapKit
import Kingfisher

final class CharactersCollectionViewCell: UICollectionViewCell {
    
    static let id = "CharacterCell"
    
    // MARK: - Private properties
    
    private lazy var charactersLayerView: UIView = {
        let charactersLayerView = UIView()
        charactersLayerView.backgroundColor = .customGrayColor
        charactersLayerView.layer.cornerRadius = 15.VAdapted
        charactersLayerView.layer.masksToBounds = true
        
        return charactersLayerView
    }()

    private lazy var charactersImageView = UIImageView()
    
    private lazy var charactersNameLabel: UILabel = {
        let charactersNameLabel = UILabel()
        charactersNameLabel.numberOfLines = 1
        charactersNameLabel.adjustsFontSizeToFitWidth = true
        charactersNameLabel.minimumScaleFactor = 0.5
        charactersNameLabel.textAlignment = .left
        charactersNameLabel.font = UIFont(name: "TrebuchetMS-Bold", size: CGFloat(30).adaptedFontSize)
        charactersNameLabel.textColor = .white
        
        return charactersNameLabel
    }()
    
    private lazy var statusLabel: StatusLabel = {
        let statusLabel = StatusLabel()
        
        return statusLabel
    }()
    
    private lazy var additionalInformation: UIStackView = {
        let additionalInformation = UIStackView()
        additionalInformation.axis = .vertical
        additionalInformation.distribution = .equalSpacing
        additionalInformation.spacing = 20.VAdapted
        
        return additionalInformation
    }()
    
    private lazy var lastKnownLocationStackView: TitleWithDescriptionStackView = {
        let lastKnownLocationStackView = TitleWithDescriptionStackView(title: "Last known location:")
        
        return lastKnownLocationStackView
    }()
    
    private lazy var firstSeenInStackView: TitleWithDescriptionStackView = {
        let firstSeenInStackView = TitleWithDescriptionStackView(title: "First seen in:")
        
        return firstSeenInStackView
    }()
    
    //MARK: - Initialization and deinitialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    private func configureCell() {
        addSubviews()
        configureLayout()
    }
}

// MARK: - Appearance Methods

private extension CharactersCollectionViewCell {
   func addSubviews() {
       addSubview(charactersLayerView)
        
       charactersLayerView.addSubview(charactersImageView)
       charactersLayerView.addSubview(charactersNameLabel)
       charactersLayerView.addSubview(statusLabel)
       
       charactersLayerView.addSubview(additionalInformation)
       additionalInformation.addArrangedSubview(lastKnownLocationStackView)
       additionalInformation.addArrangedSubview(firstSeenInStackView)
    }
    
    func configureLayout() {
        charactersLayerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(3.VAdapted)
            make.width.equalToSuperview()
        }
        
        charactersImageView.snp.makeConstraints{ make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(charactersImageView.snp.width)
            make.width.equalToSuperview()
        }

        charactersNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(charactersImageView.snp.bottom).offset(5.VAdapted)
            make.centerX.equalToSuperview()
            make.leading.equalTo(4.VAdapted)
            //make.height.equalTo(63.VAdapted)
        }
        
        statusLabel.snp.makeConstraints{ make in
            make.top.equalTo(charactersNameLabel.snp.bottom).offset(5.VAdapted)
            make.centerX.equalToSuperview()
            make.leading.equalTo(4.VAdapted)
            //make.height.equalTo(63.VAdapted)
        }
        
        additionalInformation.snp.makeConstraints{ make in
            make.top.equalTo(statusLabel.snp.bottom).offset(15.VAdapted)
            make.centerX.equalToSuperview()
            make.leading.equalTo(4.VAdapted)
            //make.height.equalTo(63.VAdapted)
        }
    }
}

// MARK: - API

extension CharactersCollectionViewCell {
    func updateData(characterInfo: CharacterInfo) {
        guard let imageURL = URL(string: characterInfo.imageURL) else { return }

        charactersImageView.kf.indicatorType = .activity
        charactersImageView.kf.setImage(with: imageURL,
                                        options: [.cacheOriginalImage])
       
        charactersNameLabel.text = characterInfo.name
        statusLabel.configureAttributedLabel(status: characterInfo.status, species: characterInfo.species)
        lastKnownLocationStackView.configure(with: characterInfo.location)
        firstSeenInStackView.configure(with: characterInfo.episode)
    }
}
