//
//  DiceRoller.swift
//  Day95Challenge
//
//  Created by Zoltan Vegh on 01/06/2025.
//

import Foundation

class DiceRoller: ObservableObject {
    enum DiceType: Int, CaseIterable, Identifiable, Codable {
        case fourSided = 4, sixSided = 6, eightSided = 8, tenSided = 10, twelveSided = 12, twentySided = 20, oneHundredSided = 100
        var id: Int { rawValue }
        var displayName: String { "D\(rawValue)" }
    }
    
    @Published var selectedDice: DiceType = .sixSided
    @Published var numOfDice: Int = 1
    @Published var rolledNumbers: [Int] = []
    
    private let resultsKey = "RolledNumbers"

    init() {
        loadResults()
    }
    
    func rollDice() {
        var results: [Int] = []
        for _ in 0..<numOfDice {
            results.append(Int.random(in: 1...selectedDice.rawValue))
        }
        rolledNumbers = results
        saveResults()
    }
    
    func calculateTotal() -> Int {
        rolledNumbers.reduce(0, +)
    }
    
    private func saveResults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(rolledNumbers) {
            UserDefaults.standard.set(data, forKey: resultsKey)
        }
    }
    
    private func loadResults() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: resultsKey),
           let savedResults = try? decoder.decode([Int].self, from: data) {
            rolledNumbers = savedResults
        }
    }
}
