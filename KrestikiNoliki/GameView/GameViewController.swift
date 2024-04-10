//
//  GameViewController.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 08.04.2024.
//

import UIKit

final class GameViewController: UIViewController {

  private let presenter: GamePresenterProtocol

  init(presenter: GamePresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Color.backgroundColor
    setupView()
    setupLayout()
    setupNavigationBar()
  }

  private func setupView() {
    view.addSubview(collectionView)
    view.addSubview(leftPlayerCard)
    view.addSubview(rightPlayerCard)
    view.addSubview(vsLabel)
    collectionView.register(
      GameCollectionViewCell.self,
      forCellWithReuseIdentifier: GameCollectionViewCell.identifier
    )
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),

      leftPlayerCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
      leftPlayerCard.widthAnchor.constraint(equalToConstant: 120),
      leftPlayerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      leftPlayerCard.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32),

      rightPlayerCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
      rightPlayerCard.widthAnchor.constraint(equalToConstant: 120),
      rightPlayerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      rightPlayerCard.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -32),

      vsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      vsLabel.centerYAnchor.constraint(equalTo: leftPlayerCard.centerYAnchor),
    ])
  }

  private func setupNavigationBar() {
    let title = UILabel()
    title.text = "Крестики и Нолики"
    title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    title.textColor = .white
    navigationItem.titleView = title
    let home = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(returnHome))
    home.tintColor = .white
    let restart = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(restartGame))
    restart.tintColor = .white
    navigationItem.rightBarButtonItem = home
    navigationItem.leftBarButtonItem = restart
  }

  @objc
  private func restartGame() {
    presenter.restartGame()
  }

  @objc
  private func returnHome() {
    dismiss(animated: true)
  }

  // MARK: - UI Elements

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = Color.buttonColor
    return collectionView
  }()

  private let leftPlayerCard: PlayerCard = {
    let card = PlayerCard(
      isEnabled: true,
      titleText: "1 игрок",
      imageName: "krestik"
    )
    card.translatesAutoresizingMaskIntoConstraints = false
    return card
  } ()

  private let rightPlayerCard: PlayerCard = {
    let card = PlayerCard(
      isEnabled: false,
      titleText: "2 игрок",
      imageName: "nolik"
    )
    card.translatesAutoresizingMaskIntoConstraints = false
    return card
  } ()

  private let vsLabel: UILabel = {
    let label = UILabel()
    label.text = "VS"
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold, width: .expanded)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  } ()

  private func drawWinningLines(start: CGPoint, end: CGPoint) {
    let vertical = collectionView.frame.height/3
    let horizontal = collectionView.frame.width/3

    let lineLayer = CAShapeLayer()
    let linePath = UIBezierPath()
    linePath.move(to: CGPoint(x: start.x*horizontal + horizontal/2, y: start.y*vertical + vertical/2))
    linePath.addLine(to: CGPoint(x: end.x*horizontal + horizontal/2, y: end.y*vertical + vertical/2))
    lineLayer.path = linePath.cgPath
    lineLayer.strokeColor = Color.foregroundTitleColor.cgColor
    lineLayer.lineWidth = 20.0
    lineLayer.strokeEnd = 0.0

    collectionView.layer.addSublayer(lineLayer)

    let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeEndAnimation.fromValue = 0.0
    strokeEndAnimation.toValue = 1.0
    strokeEndAnimation.duration = 0.5

    lineLayer.add(strokeEndAnimation, forKey: "lineAnimation")
    lineLayer.strokeEnd = 1.0

  }

}

// MARK: - GameViewProtocol

extension GameViewController: GameViewProtocol {
  func updateGrid(isGameEnd: Bool = false) {
    if isGameEnd {
      collectionView.layer.sublayers?.removeLast()
    }
    self.collectionView.reloadData()
  }

  func updateTurn(player: Player) {
    switch player {
    case .krestik:
      leftPlayerCard.isEnabled = true
      rightPlayerCard.isEnabled = false
    case .nolik:
      leftPlayerCard.isEnabled = false
      rightPlayerCard.isEnabled = true
    }
  }

  func showWinner(player: Player, winningCombination: [Int]) {
    var start = CGPoint(x: winningCombination[0]%3, y: winningCombination[0]/3)
    var end = CGPoint(x: winningCombination[2]%3, y: winningCombination[2]/3)

    drawWinningLines(start: start, end: end)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GameViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter.putPlayer(at: indexPath.item)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 3
    return CGSize(width: width, height: width)
  }
}

// MARK: - UICollectionViewDataSource

extension GameViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 9
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: GameCollectionViewCell.identifier,
      for: indexPath
    ) as? GameCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.player = presenter.getPlayer(at: indexPath.item)
    return cell
  }
}


