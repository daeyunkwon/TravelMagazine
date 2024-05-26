//
//  Protocols.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/26/24.
//

import Foundation

protocol RestaurantTableViewCellDelegate: AnyObject {
    func handleLikeButtonTapped(for cell: RestaurantTableViewCell)
}
