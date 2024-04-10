//
//  PlayerCard.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 11.04.2024.
//

import UIKit

final class PlayerCard: UIView {

  var isEnabled: Bool {
    didSet {
      updateView()
    }
  }

  init(
    isEnabled: Bool,
    titleText: String,
    imageName: String
  ) {
    self.isEnabled = isEnabled
    super.init(frame: .zero)
    setupView()
    setupLayout()
    updateView()
    title.text = titleText
    imageView.image = UIImage(named: imageName)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  private func setupView() {
    self.layer.cornerRadius = 16.0
    self.layer.borderWidth = 2.0
    self.backgroundColor = Color.buttonColor

    self.addSubview(title)
    self.addSubview(imageView)
  }

  private func updateView() {
    self.layer.borderColor = isEnabled ? Color.foregroundTitleColor.cgColor : nil
    self.imageView.alpha = isEnabled ? 1.0 : 0.4
    self.title.textColor = isEnabled ? .white : .gray
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),

      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
    ])
  }

  private let title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .bold, width: .expanded)
    label.textColor = .white
    return label
  } ()

  private let imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  } ()
}
