//
//  ContactListTableViewCell.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    private var contact: ContactViewModal?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        // Initialization code
    }
    
    func setupViews(){
        self.contentImageView.layer.cornerRadius = self.contentImageView.frame.height/2
        self.backgroundColor = .clear
        self.contentImageView.image = UIImage.init(named: ImageConstants.placeHolderImage)
    }
    
    func bindData(item: ContactViewModal){
        contact = item
        self.titleLabel.text = item.contactName
        self.setFavoriteButtonState(status: item.isFavorited)
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        if let isFavorited: Bool = contact?.isFavorited, isFavorited{
            self.setFavoriteButtonState(status: isFavorited)
        }else{
            self.setFavoriteButtonState(status: false)
        }
    }
    
    private func setFavoriteButtonState(status: Bool){
        if status{
            self.favoriteButton.setImage(UIImage.init(named: ImageConstants.favoriteStatus), for: .normal)
        }else{
            self.favoriteButton.setImage(UIImage.init(named: ""), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
