//
//  PhotosCollectionViewCell.swift
//  TestTaskIT-Link
//
//  Created by Денис Набиуллин on 20.05.2023.
//

import UIKit.UICollectionViewCell
import SDWebImage

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignData(_ imageURL: String){
        let url = URL(string: "\(imageURL)")
        photoImageView.sd_setImage(with: url, completed: nil)
    }
}

private extension PhotosCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
