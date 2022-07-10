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
    
    private let viewModel = MainViewModel()
    
    private var currentPage = 0
    
    private lazy var charactersCollectionViewHeight = 650.VAdapted
    private lazy var charactersCollectionViewWidth = 290.HAdapted
    
    private lazy var charactersCollectionViewSideInset = 25.HAdapted
    
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
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel.view = self
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
        
        viewModel.loadCharacters()
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
            make.bottom.equalToSuperview().offset(-100.VAdapted)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(charactersCollectionViewHeight)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as! CharactersCollectionViewCell
        
        cell.updateData(characterInfo: viewModel.getCharacterInfo(for: indexPath))
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
        var pageWidth: CGFloat = 0
        let currentPageWidth = charactersCollectionViewWidth + charactersCollectionViewSideInset - charactersCollectionViewFrameSpacing
        if currentPage != 0 {
            pageWidth = charactersCollectionViewWidth + charactersCollectionViewSideInset
        }

        var newPage = currentPage

        if velocity.x != 0 {
            newPage = velocity.x > 0 ? currentPage + 1 : currentPage - 1
            if newPage < 0 {
                newPage = viewModel.numberOfItems - 1
            }
            if newPage > viewModel.numberOfItems - 1 {
                newPage = 0
            }
        }

        currentPage = newPage
        let point = CGPoint (x: CGFloat(newPage - 1) * pageWidth + currentPageWidth, y: 0)
        targetContentOffset.pointee = point
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                self.startLoading()
            case .success:
                self.stopLoading()
               // self.tableView.setContentOffset(.zero, animated: true)
                //self.charactersCollectionView.setContentOffset(.zero, animated: true)
                self.charactersCollectionView.reloadData()
            case .error(let error):
                self.stopLoading()
                self.presentDefaultAlert(title: "Something went wrong!",
                                         message: error.localizedDescription,
                                         buttonTitle: "Try Again") { self.viewModel.loadCharacters() }
            }
        }
    }
}


