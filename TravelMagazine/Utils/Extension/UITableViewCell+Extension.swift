//
//  UITableViewCell+Extension.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

extension UITableViewCell {
    func highlightSearchWord(word: String?, label: UILabel) {
        guard let word = word, !word.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        guard let labelText = label.text?.trimmingCharacters(in: .whitespaces) else {return}
        
        var rangeArr: [NSRange] = []
        
        let attributedStr = NSMutableAttributedString(string: labelText)
        
        findRange(entireString: labelText, searchWord: word, rangeArray: &rangeArr)
        
        for range in rangeArr {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        }
        
        label.attributedText = attributedStr
    }
    
    private func findRange(entireString: String, searchWord: String, rangeArray: inout [NSRange]) {
        let attributedStr = NSMutableAttributedString(string: entireString)
        let entireLength = entireString.count
        var range = NSRange(location: 0, length: entireLength)
        
        while range.location != NSNotFound {
            range = (attributedStr.string as NSString).range(of: searchWord, options: .caseInsensitive, range: range)
            rangeArray.append(range)
            
            if range.location != NSNotFound {
                range = NSRange(location: range.location + range.length, length: entireLength - (range.location + range.length))
            }
        }
    }
}
