//
//  cardCell.swift
//  RMparsing
//
//  Created by Антон Заричный on 19.09.2022.
//

import UIKit

class RickCell: UICollectionViewCell {
    @IBOutlet var rickImage: UIImageView!
    @IBOutlet var rickNameLabel: UILabel!

    func configure(with character: Character) {
        self.layer.cornerRadius = 15
        
        rickNameLabel.text = character.name
        rickNameLabel.layer.masksToBounds = true
        rickNameLabel.layer.cornerRadius = 10
        
        NetworkManager.shared.fetchDataAF(url: character.image ?? "") { result in
            switch result {
            case .success(let imageData):
                self.rickImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
