//
//  MortyCell.swift
//  RMparsing
//
//  Created by Антон Заричный on 22.09.2022.
//

import UIKit

class MortyCell: UICollectionViewCell {
    @IBOutlet var mortyImage: UIImageView!
    @IBOutlet var mortyNameLabel: UILabel!
 
    func configure(with character: Character) {
        self.layer.cornerRadius = 15
        
        mortyNameLabel.text = character.name
        mortyNameLabel.layer.masksToBounds = true
        mortyNameLabel.layer.cornerRadius = 10
    
        NetworkManager.shared.fetchDataAF(url: character.image ?? "") { result in
            switch result {
            case .success(let imageData):
                self.mortyImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
