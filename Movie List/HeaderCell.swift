//
//  HeaderCell.swift
//  IMDB
//
//  Created by Rodrigo de Anhaia on 23/03/22.
//

import UIKit


class HeaderCell: UITableViewCell {
    static var id: String = "HeaderCell"
    var title: String?
    
    @IBOutlet weak var headerTitle: UILabel!
    
    func reload() {
        headerTitle.text = title
        
    }
}
