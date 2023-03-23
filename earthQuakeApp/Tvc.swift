//
//  Tvc.swift
//  earthQuakeApp
//
//  Created by Semih Karahan on 20.02.2023.
//

import UIKit

class Tvc: UITableViewCell {
/*
    @IBOutlet weak var sehir: UILabel!
    @IBOutlet weak var zaman: UILabel!
    @IBOutlet weak var siddet: UILabel!
    @IBOutlet weak var derinlik: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lng: UILabel!
   */
    
    
    @IBOutlet weak var sehir: UILabel!
    
    @IBOutlet weak var zaman: UILabel!
    
    @IBOutlet weak var siddet: UILabel!
    
    @IBOutlet weak var derinlik: UILabel!
    
    @IBOutlet weak var lat: UILabel!
    
    
    @IBOutlet weak var lng: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
