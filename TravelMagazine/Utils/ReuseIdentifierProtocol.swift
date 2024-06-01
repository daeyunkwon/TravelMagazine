//
//  ReuseIdentifierProtocol.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/1/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var reuseIdentifier: String {get}
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
