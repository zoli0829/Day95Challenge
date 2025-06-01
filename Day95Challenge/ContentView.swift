//
//  ContentView.swift
//  Day95Challenge
//
//  Created by Zoltan Vegh on 01/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var diceRoller = DiceRoller()
    @State private var showingDicePicker = false
    
    var body: some View {
        VStack {
            Button("Choose Dice: \(diceRoller.selectedDice.displayName)") {
                showingDicePicker = true
            }
            .sheet(isPresented: $showingDicePicker) {
                VStack {
                    Text("Select a dice").font(.headline)
                    List(DiceRoller.DiceType.allCases) { dice in
                        Button(dice.displayName) {
                            diceRoller.selectedDice = dice
                            showingDicePicker = false
                        }
                    }
                }
            }
            
            Stepper("Number of Dice: \(diceRoller.numOfDice)", value: $diceRoller.numOfDice, in: 1...20)
                .padding(.horizontal)
            
            Button(action: {
                diceRoller.rollDice()
            }) {
                Text("🎲 Roll Dice")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 4)
            }
            .padding(.horizontal)
            
            if !diceRoller.rolledNumbers.isEmpty {
                Text("Results: \(diceRoller.rolledNumbers.map { String($0) }.joined(separator: ", "))")
                    .font(.headline)
                    .padding(.top)
                
                Text("Total rolled: \(diceRoller.calculateTotal())")
                    .font(.largeTitle)
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
