//
//  UIImageView+URL.swift
//  Pizza
//
//  Created by Yulya Greshnova on 15.10.2022.
//

import Foundation
import Nuke

extension UIImageView {
    func loadFrom(urlAddress: String) {
        Nuke.loadImage(with: urlAddress, into: self)
    }
}
