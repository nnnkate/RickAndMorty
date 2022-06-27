//
//  CharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Екатерина Неделько on 23.06.22.
//

import UIKit
import SnapKit

final class CharactersCollectionViewCell: UICollectionViewCell {
    
    static let id = "CharacterCell"
    
    private var charactersLayerView = UIView()

    private var charactersImageView = UIImageView()
    private var charactersNameLabel = UILabel()

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
        setupAppearance()
        addSubviews()
        configureLayout()
    }
    
    func updateData(character: Character) {
        guard let url = URL(string: character.image) else { return }

        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.charactersImageView.image = UIImage(data: data)
                }
            }
            catch let error {
               print(error)
            }
        }
       
        charactersNameLabel.text = character.name
    }
}

// MARK: - Appearance Methods

private extension CharactersCollectionViewCell {
    func setupAppearance() {
        charactersLayerView.backgroundColor = .gray
        charactersLayerView.layer.cornerRadius = 15.VAdapted
        charactersLayerView.layer.masksToBounds = true
        
        charactersNameLabel.numberOfLines = 0
        charactersNameLabel.adjustsFontSizeToFitWidth = true
        charactersNameLabel.textAlignment = .left
        charactersNameLabel.font = UIFont(name: "TrebuchetMS-Bold", size: CGFloat(30).adaptedFontSize)
        charactersNameLabel.frame = CGRect(x: 0, y: 0, width: 306.HAdapted, height: 63.VAdapted)
        charactersNameLabel.textColor = .white
    }
    
    func addSubviews() {
        addSubview(charactersLayerView)
        
        charactersLayerView.addSubview(charactersImageView)
        charactersLayerView.addSubview(charactersNameLabel)
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
            make.top.equalTo(charactersImageView.snp.bottom).offset(-10.VAdapted)
            make.leading.equalTo(4.VAdapted)
            make.width.equalTo(306.HAdapted)
            make.height.equalTo(63.VAdapted)
        }
    }
}
