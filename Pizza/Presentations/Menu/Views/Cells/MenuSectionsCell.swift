//
//  MenuSectionsCell.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

protocol MenuSectionsCellDelegate: AnyObject {
    func didChooseMenu(index: Int)
}

final class MenuSectionsCell: UICollectionReusableView {
    static let identifire = "MenuSectionsCell"
    static let kindSectionHeader = "MenuHeader"
    private let scrollView: UIScrollView
    private let stackView: UIStackView
    private var selectedButton: UIButton?
    private var buttons: [UIButton]
    weak var delegate: MenuSectionsCellDelegate?
    
    override init(frame: CGRect) {
        scrollView = UIScrollView()
        stackView = UIStackView()
        buttons = []
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(viewModels: [MenuSectionsViewModel]) {
        buttons.removeAll()
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        viewModels.forEach {
            let button = UIButton()
            button.backgroundColor = .clear
            let title = NSAttributedString(string: $0.name,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 13),
                                                                     .foregroundColor: UIColor.accentForegroundPinkWithAlpha])
            
            let selectedTitle = NSAttributedString(string: $0.name,
                                                   attributes: [.font: UIFont.boldSystemFont(ofSize: 13),
                                                                .foregroundColor: UIColor.accentRed])
            button.setAttributedTitle(title, for: .normal)
            button.setAttributedTitle(selectedTitle, for: .selected)
            button.layer.cornerCurve = .continuous
            button.layer.cornerRadius = 16
            button.layer.borderColor = UIColor.accentForegroundPinkWithAlpha.cgColor
            button.layer.borderWidth = 1
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(chooseMenu(sender:)), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.widthAnchor.constraint(equalToConstant: 88).isActive = true
            button.translatesAutoresizingMaskIntoConstraints = false
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        if selectedButton == nil, let button = buttons.first {
            markButtonSelected(button)
        }
    }
    
    @objc func chooseMenu(sender: UIButton) {
        markButtonSelected(sender)
        if let index = buttons.firstIndex(where: { $0 === sender }) {
            delegate?.didChooseMenu(index: index)
        }
    }
    
    func markButtonSelected(_ button: UIButton) {
        selectedButton?.backgroundColor = .clear
        selectedButton?.isSelected = false
        
        button.layer.backgroundColor = UIColor.accentBackgroundPinkWithAlpha.cgColor
        button.isSelected = true
        selectedButton = button
    }
}

//MARK: - PrivateFunctions
private extension MenuSectionsCell {
    func setupView() {
        backgroundColor = .backgroundGreyColor
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalToConstant: 32),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        ])
    }
}
