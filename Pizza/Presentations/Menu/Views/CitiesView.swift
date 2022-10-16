//
//  CitiesView.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

final class CitiesView: UIView {
    private let citiesLabel: UILabel
    private let chooseCityButton: UIButton
    
    init() {
        citiesLabel = UILabel()
        chooseCityButton = UIButton()
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - PrivateFunctions
private extension CitiesView {
    func setupView() {
        backgroundColor = .backgroundGreyColor
       
        citiesLabel.text = "Москва"
        citiesLabel.textColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        citiesLabel.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        citiesLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(citiesLabel)
        
        chooseCityButton.setImage(UIImage(named: "arrowDown"), for: .normal)
        chooseCityButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chooseCityButton)
        
        NSLayoutConstraint.activate([
            citiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            citiesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chooseCityButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            chooseCityButton.leadingAnchor.constraint(equalTo: citiesLabel.trailingAnchor, constant: 8),
            chooseCityButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
