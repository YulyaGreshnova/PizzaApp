//
//  BannersCell.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

final class BannersCell: UICollectionReusableView {
    static let identifire = "BannersCell"
    static let kindSectionHeader = "BannersHeader"
    
    private let scrollView: UIScrollView
    private let bannerStackView: UIStackView
    
    override init(frame: CGRect) {
        scrollView = UIScrollView()
        bannerStackView = UIStackView()
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(bannersViewModel: [BannerViewModel]) {
        bannersViewModel.forEach {
            let bannerImageView = UIImageView()
            bannerImageView.image = UIImage(named: $0.name)
            bannerImageView.layer.cornerRadius = 10
            bannerImageView.clipsToBounds = true
            bannerImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            bannerImageView.heightAnchor.constraint(equalToConstant: 112).isActive = true
            bannerImageView.translatesAutoresizingMaskIntoConstraints = false
            bannerImageView.contentMode = .scaleAspectFill
            bannerStackView.addArrangedSubview(bannerImageView)
        }
    }
}

//MARK: - PrivateFunctions
private extension BannersCell {
    func setupView() {
        backgroundColor = .backgroundGreyColor
     
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        bannerStackView.axis = .horizontal
        bannerStackView.spacing = 10
        bannerStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bannerStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalToConstant: 112),
            
            bannerStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            bannerStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            bannerStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            bannerStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        ])
    }
}
