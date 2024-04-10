//
//  GamePresenter.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 09.04.2024.
//

import Foundation

protocol GamePresenterProtocol {
  func getPlayer(at item: Int) -> Player?

  func putPlayer(at index: Int)

  func restartGame()
}

protocol GameViewProtocol: NSObject {
  func updateGrid(isGameEnd: Bool)

  func updateTurn(player: Player)

  func showWinner(player: Player, winningCombination: [Int])
}

final class GamePresenter: GamePresenterProtocol {

  weak var gameView: GameViewProtocol?

  private var model: GameModel

  init(model: GameModel) {
    self.model = model
  }

  func getPlayer(at index: Int) -> Player? {
    model.grid[index]
  }

  func putPlayer(at index: Int) {
    guard model.grid[index] == nil,
          model.isGameEnd == false else { return }
    model.grid[index] = model.turn
    model.turn = (model.turn == .krestik ? .nolik : .krestik)
    gameView?.updateTurn(player: model.turn)
    gameView?.updateGrid(isGameEnd: false)
    checkForWinner()
  }

  func restartGame() {
    model.turn = .krestik
    model.grid = Array(repeating: nil, count: 9)
    gameView?.updateGrid(isGameEnd: model.isGameEnd)
    gameView?.updateTurn(player: model.turn)
    model.isGameEnd = false
  }

  private func checkForWinner() {
    let combinations: [[Int]] = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    for comb in combinations {
      if model.grid[comb[0]] == model.grid[comb[1]],
         model.grid[comb[1]] == model.grid[comb[2]],
         let player = model.grid[comb[0]] {
        gameView?.showWinner(player: player, winningCombination: comb)
        model.isGameEnd = true
      }
    }
  }

}
