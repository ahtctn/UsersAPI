//
//  UserListTableViewCell.swift
//  UsersAPI
//
//  Created by Ahmet Ali ÇETİN on 1.04.2023.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    var user: UserModel? {
        didSet {
            userDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productCustomization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func userDetailConfiguration() {
        guard let user else { return }
        nameSurnameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        mailLabel.text = "✉️\(user.email)"
    }
    
    func productCustomization() {
        backgroundImage.clipsToBounds = false
        backgroundImage.layer.cornerRadius = 15
        self.backgroundImage.backgroundColor = .systemGray6
    }
}
