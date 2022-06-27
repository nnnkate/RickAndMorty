//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Екатерина Неделько on 22.06.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let charactersService: CharactersService
    private var charactersData: [Character]?
    
    private var currentPage = 0
    
    private lazy var charactersCollectionViewHeight = 500.VAdapted
    private lazy var charactersCollectionViewWidth = 280.HAdapted
    
    private lazy var charactersCollectionViewSideInset = 30.HAdapted
    
    private lazy var charactersCollectionViewFrameSpacing = (view.bounds.width - charactersCollectionViewWidth) / 2

    // MARK: - Views
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = charactersCollectionViewSideInset
        
        return layout
    }()
    
    private lazy var charactersCollectionView: UICollectionView = {
        let charactersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        
        charactersCollectionView.contentInset = UIEdgeInsets(top: 0, left: charactersCollectionViewSideInset, bottom: 0, right: charactersCollectionViewSideInset);
        
        charactersCollectionView.register(CharactersCollectionViewCell.self,
                                          forCellWithReuseIdentifier: "CharactersCell")
 
        return charactersCollectionView
    }()
    
     //MARK: - Initialization and deinitialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        charactersService = CharactersService()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        addSubviews()
        configureLayout()
        
        charactersService.getAllCharacters() { [weak self] results, error in
            self?.charactersData = results
            self?.charactersCollectionView.reloadData()
        }
    }

}

// MARK: - Appearance Methods

private extension MainViewController {
    func setupAppearance() {
        view.backgroundColor = .darkGray
        
        charactersCollectionView.backgroundColor = .clear
        charactersCollectionView.showsHorizontalScrollIndicator = false
        charactersCollectionView.decelerationRate = .fast
    }
    
    func addSubviews() {
        view.addSubview(charactersCollectionView)
    }
    
    func configureLayout() {
        charactersCollectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-187.VAdapted)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(charactersCollectionViewHeight)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let charactersData = charactersData else { return 0 }
        
        return charactersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as! CharactersCollectionViewCell
        
        guard let charactersData = charactersData else { return cell }
        
        cell.updateData(character: charactersData[indexPath.row])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: charactersCollectionViewWidth, height: charactersCollectionViewHeight)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let charactersData = charactersData else { return }

        charactersCollectionView.reloadItems(at: [IndexPath(row: currentPage, section: 0)])

        var pageWidth: CGFloat = 0
        let currentPageWidth = charactersCollectionViewWidth + charactersCollectionViewSideInset - charactersCollectionViewFrameSpacing
        if currentPage != 0 {
            pageWidth = charactersCollectionViewWidth + charactersCollectionViewSideInset
        }

        var newPage = currentPage

        if velocity.x != 0 {
            newPage = velocity.x > 0 ? currentPage + 1 : currentPage - 1
            if newPage < 0 {
                newPage = charactersData.count - 1
            }
            if newPage > charactersData.count - 1 {
                newPage = 0
            }
        }

        currentPage = newPage
        let point = CGPoint (x: CGFloat(newPage - 1) * pageWidth + currentPageWidth, y: 0)
        targetContentOffset.pointee = point
    }
}


