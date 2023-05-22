//
//  MainViewController.swift
//  TestTaskIT-Link
//
//  Created by Денис Набиуллин on 20.05.2023.
//

import UIKit

protocol ImageURLProviderDelegate: AnyObject {
    func provideImageURL(_ url: String)
}

final class MainViewController: UIViewController {
    
    weak var delegate: ImageURLProviderDelegate?
    private var imagesArray: [String] = []
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.sectionInset.left = 25
        layout.sectionInset.right = 25
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentMode = .scaleAspectFill
        collection.register(PhotosCollectionViewCell.self,
                            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchPhotos()
    }
    
    private func fetchPhotos() {
        ImageRequestManager.shared.loadImagesURLString { [weak self] photosArray in
            guard let self = self else { return }
            self.imagesArray = photosArray
            self.photosCollectionView.reloadData()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(photosCollectionView)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        setConstraints()
    }
}
//MARK: - extension DetailViewController: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let stringURL = imagesArray[indexPath.item]
        let delegateVC = DetailViewController()
        delegate = delegateVC
        delegate?.provideImageURL(stringURL)
        navigationController?.pushViewController(delegateVC, animated: true)
    }
}
//MARK: - extension DetailViewController: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier,
                                                            for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let image = imagesArray[indexPath.item]
        cell.assignData(image)
        return cell
    }
}
//MARK: - extension DetailViewController: setConstraints
private extension MainViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
