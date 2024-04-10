//
//  GameModel.swift
//  KrestikiNoliki
//
//  Created by Medeu Pazylov on 10.04.2024.
//

import Foundation

enum Player {
  case krestik
  case nolik
}

enum Game {
  case single
  case dual
}

struct GameModel {
  var game: Game = .single
  var grid: [Player?] = Array(repeating: nil, count: 9)
  var turn: Player = .krestik
  var isGameEnd: Bool = false
}
