//
//  CollectionViewController.swift
//  RMparsing
//
//  Created by Антон Заричный on 19.09.2022.
//

import UIKit

final class RickCollectionViewController: UICollectionViewController {
    
    private var arrayInfo: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchInfoAF()
    }
        
    // MARK: - UICollectionView

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayInfo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RickCell", for: indexPath) as! RickCell
        
        let character = arrayInfo[indexPath.item]
        
        cell.configure(with: character)
        
        return cell
    }
}
 
    // MARK: - UICollectionViewDelegateFlowLayout
extension RickCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow : CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availabelWidth = collectionView.frame.width - paddingWidth
        let withPerItem = availabelWidth / itemsPerRow
        return CGSize(width: withPerItem, height: withPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
}

extension RickCollectionViewController {
    private func fetchInfoAF() {
        for index in 0..<RickInfo.allCases.count {
            NetworkManager.shared.fetchInfoAF(url: RickInfo.allCases[index].rawValue) { result in
                switch result {
                case .success(let characters):
                    self.arrayInfo += characters
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

