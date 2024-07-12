//
//  SettingsView.swift
//  Eductainment
//
//  Created by Nicholas Johnson on 7/12/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var maxNumber = 12
    @State private var questionAmount = 10
    @Binding var firstSet: [Int]
    @Binding var secondSet: [Int]
    @Binding var showGame: Bool
    
    let questionAmounts = [5, 10, 15]
    
    func generateNumbersArray(max: Int, amount: Int) -> [Int] {
        var numbers = [Int]()
        for _ in 1...max {
            numbers.append(Int.random(in: 2...12))
        }
        return numbers
    }
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("What numbers do you want to practice multiplying?")
                Stepper("Up to: \(maxNumber)", value: $maxNumber, in: 2...12)
            }
            VStack(alignment: .leading) {
                Text("How many questions do you want to be asked?")
                Picker("Question amount: \(questionAmount)", selection: $questionAmount, content: {
                    ForEach(questionAmounts, id: \.self) { amount in
                        Text(amount.formatted())
                    }
                })
                .pickerStyle(.segmented)
            }
            VStack {
                Button("Start Game") {
                    firstSet = generateNumbersArray(max: maxNumber, amount: questionAmount)
                    secondSet = generateNumbersArray(max: maxNumber, amount: questionAmount)
                    showGame = true
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(25)
            }
        }
        .navigationTitle("Multiply with Me!")
    }
}

