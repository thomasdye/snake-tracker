//
//  Snake.swift
//  Snake Tracker
//
//  Created by Thomas Dye on 11/13/21.
//

import Foundation

var allSnakes: [Snake] = []

struct Snake: Codable {
  let name: String
  let morph: String
  let age: Int
  let feedingTimes: [Feed]
  let frozen: Bool
  let foodSize: Int
}

struct Feed: Codable {
  let type: Food
  let date: Date
}

struct Food: Codable {
  let type: String
  let size: Int
}

