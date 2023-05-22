//
//  DetailViewController.swift
//  TestTaskIT-Link
//
//  Created by Денис Набиуллин on 20.05.2023.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    private var isTapped = false
    
    private let onScreenPhotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        screenPhotoImageViewDidTap()
        addGesture()
    }
    //MARK: - viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        checkImageSize()
    }
    
    private func addGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self,
                                                    action: #selector(handlePinchGesture(_:)))
        onScreenPhotoImageView.addGestureRecognizer(pinchGesture)
    }
    
    private func checkImageSize() {
        guard let imageSize = onScreenPhotoImageView.image?.size else { return }
        let viewSize = view.bounds.size
        if imageSize.width > viewSize.width || imageSize.height > viewSize.height {
            setConstraintsBigImageView()
        }
    }
    
    private func screenPhotoImageViewDidTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageDidTap))
        view.addGestureRecognizer(tap)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(onScreenPhotoImageView)
        setConstraintsNormalImageView()
    }
}
//MARK: - extension DetailViewController: @objc Actions
private extension DetailViewController {
    @objc private func imageDidTap() {
        isTapped.toggle()
        navigationController?.setNavigationBarHidden(isTapped, animated: true)
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        let scaleResult = gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        gesture.view?.transform = scale
        gesture.scale = 1
    }
}
//MARK: - extension DetailViewController: Delegate
extension DetailViewController: ImageURLProviderDelegate {
    func provideImageURL(_ url: String) {
        guard let url = URL(string: "\(url)") else { return }
        onScreenPhotoImageView.sd_setImage(with: url, completed: nil)
    }
}
//MARK: - extension DetailViewController: setConstraints
private extension DetailViewController {
    func setConstraintsNormalImageView() {
        NSLayoutConstraint.activate([
            onScreenPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onScreenPhotoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func setConstraintsBigImageView() {
        NSLayoutConstraint.deactivate([
            onScreenPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onScreenPhotoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            onScreenPhotoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            onScreenPhotoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            onScreenPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            onScreenPhotoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
        ])
    }
}
