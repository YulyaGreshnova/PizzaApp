//
//  MenuCell.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

final class MenuCell: UICollectionViewCell {
    static let identifire = "MenuCell"
    private let nameLabel: UILabel
    private let ingredientsLabel: UILabel
    private let priceButton: UIButton
    private let productImageView: UIImageView
    
    override init(frame: CGRect) {
        nameLabel = UILabel()
        ingredientsLabel = UILabel()
        priceButton = UIButton()
        productImageView = UIImageView()
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(menuItemViewModel: MenuItemViewModel) {
        nameLabel.text = menuItemViewModel.name
        ingredientsLabel.text = menuItemViewModel.ingridients
        priceButton.setTitle("от \(menuItemViewModel.price)р", for: .normal)
        productImageView.loadFrom(urlAddress: menuItemViewModel.imageUrl)
        
        if menuItemViewModel.isFirst {
            contentView.layer.cornerRadius = 20
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentView.clipsToBounds = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
}

//MARK: - PrivateFunctions
private extension MenuCell {
    func setupView() {
        contentView.backgroundColor = .white
      
        productImageView.image = UIImage(named: "pizza")
        productImageView.contentMode = .scaleAspectFill
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
      
        nameLabel.numberOfLines = 2
        nameLabel.textColor =  .accentGray
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        contentView.addSubview(nameLabel)
        
        ingredientsLabel.textColor =  .accentLightGray
        ingredientsLabel.font = .systemFont(ofSize: 13)
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.lineBreakMode = .byWordWrapping
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ingredientsLabel)
        
        priceButton.setTitleColor(.accentRed, for: .normal)
        priceButton.titleLabel?.font = .systemFont(ofSize: 13)
        priceButton.layer.cornerRadius = 6
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = UIColor.accentRed.cgColor
        priceButton.contentEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 18)
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceButton)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 132),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            ingredientsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ingredientsLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 32),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            priceButton.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 16),
            priceButton.heightAnchor.constraint(equalToConstant: 32),
            priceButton.trailingAnchor.constraint(equalTo: ingredientsLabel.trailingAnchor),
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
