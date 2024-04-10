//
//  GameCollectionViewCell.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 09.04.2024.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {

  static let identifier = "GameCollectionCell"

  var player: Player? = nil {
    didSet {
      switch player {
      case .krestik:
        imageView.image = UIImage(named: "krestik")
      case .nolik:
        imageView.image = UIImage(named: "nolik")
      case .none:
        imageView.image = nil
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupViews() {
    self.addSubview(imageView)
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 2
    backgroundColor = .clear
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
      imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
    ])
  }

  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  } ()
}
