//
//  ViewController.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 06.04.2024.
//

import UIKit

final class MainMenuViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Color.backgroundColor
    setupView()
    setupLayout()
  }

  private func setupView() {
    view.addSubview(titleLabel)
    view.addSubview(singlePlayerButton)
    view.addSubview(dualPlayerButton)
    singlePlayerButton.addTarget(self, action: #selector(openGameController), for: .touchUpInside)
    dualPlayerButton.addTarget(self, action: #selector(openGameController), for: .touchUpInside)
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
      titleLabel.widthAnchor.constraint(equalToConstant: 300),

      singlePlayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      singlePlayerButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 64),
      singlePlayerButton.widthAnchor.constraint(equalToConstant: 240),
      singlePlayerButton.heightAnchor.constraint(equalToConstant: 64),

      dualPlayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dualPlayerButton.topAnchor.constraint(equalTo: singlePlayerButton.bottomAnchor, constant: 16),
      dualPlayerButton.widthAnchor.constraint(equalToConstant: 240),
      dualPlayerButton.heightAnchor.constraint(equalToConstant: 64),
    ])
  }

  @objc
  func openGameController() {
    let gamePresenter = GamePresenter(model: GameModel())
    let gameViewController = GameViewController(presenter: gamePresenter)
    gamePresenter.gameView = gameViewController
    let nvc = UINavigationController(rootViewController: gameViewController)
    nvc.modalPresentationStyle = .fullScreen
    nvc.modalTransitionStyle = .crossDissolve
    self.present(nvc, animated: true)
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Крестики Нолики"
    label.font = UIFont.systemFont(ofSize: 40, weight: .bold, width: .expanded)
    label.textColor = Color.foregroundTitleColor
    label.textAlignment = .center
    label.layer.shadowColor = UIColor.white.cgColor
    label.layer.shadowOpacity = 0.9
    label.layer.shadowRadius = 36
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  } ()

  private let singlePlayerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("1 Игрок", for: .normal)
    button.backgroundColor = Color.buttonColor
    button.layer.cornerRadius = 16
    return button
  } ()

  private let dualPlayerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("2 Игрока", for: .normal)
    button.backgroundColor = Color.buttonColor
    button.layer.cornerRadius = 16
    return button
  } ()

}

