//
//  TableViewCell.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/31.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var uiView: UIView!
    
    @IBOutlet var reationLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        uiView.layer.cornerRadius = uiView.frame.size.height / 5
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 6, bottom: 6, right: 6))
    }
    
}
