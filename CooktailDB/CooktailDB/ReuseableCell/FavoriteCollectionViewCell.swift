//
//  FavoriteCollectionViewCell.swift
//  CooktailDB
//
//  Created by Thanh Duong on 13/09/2023.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell, ReusableView {
    static var defaultReuseIdentifier = Constant.FavoriteCollectionViewConfig.cellWithReuseIdentifier
    @IBOutlet private weak var leadView2: UIView!
    @IBOutlet private weak var leadView1: UIView!
    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var favoriteCooktailImage: UIImageView!
    @IBOutlet private weak var favoriteCooktailName: UILabel!
    @IBOutlet private weak var favoriteCooktailAlcoholic: UILabel!
    @IBOutlet private weak var cooktailCategory: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    private func config() {
        backgroundColor = UIColor(hex: "#FB7D8A")
        layer.cornerRadius = Constant.FavoriteCollectionViewConfig.cornerRadius
        favoriteCooktailImage.layer.cornerRadius = Constant.FavoriteCollectionViewConfig.imageConnerRadius
        leadView1.layer.cornerRadius = Constant.FavoriteCollectionViewConfig.cornerRadius
        leadView2.layer.cornerRadius = Constant.FavoriteCollectionViewConfig.cornerRadius
        background.layer.cornerRadius = Constant.FavoriteCollectionViewConfig.cornerRadius
    }

    func setData(cooktail: Cooktail) {
        guard let cooktailImage = cooktail.cooktailImage else { return }
        let safeUrl = cooktailImage + "/preview"
        APIManager.shared.getImg(url: safeUrl) { [weak self] image in
            guard let self = self else { return }
            self.favoriteCooktailImage.image = image
        }
        favoriteCooktailName.text = cooktail.cooktailName
        favoriteCooktailAlcoholic.text = cooktail.cooktailAlcoholic
        cooktailCategory.text = cooktail.cooktailCategory
    }

}
