//
//  GameView.swift
//  Eductainment
//
//  Created by Nicholas Johnson on 7/12/24.
//

import SwiftUI

struct GameView: View {
    @Binding var score: Int
    @Binding var currentQuestion: Int
    @Binding var firstSet: [Int]
    @Binding var secondSet: [Int]
    @Binding var userAnswer: String
    @Binding var showAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    
    
    func checkAnswer() {
        if userAnswer == String(firstSet[currentQuestion] * secondSet[currentQuestion]) {
            score += 1
            showAlert(title: "Correct!", body: "You are correct!")
        } else {
            let correctAnswer = firstSet[currentQuestion] * secondSet[currentQuestion]
            showAlert(title: "Incorrect!", body: "The correct answer is \(correctAnswer).")
        }
    }
    
    func showAlert(title: String, body: String) {
        alertTitle = title
        alertMessage = body
        showAlert = true
    }
    
    var body: some View {
        List {
            Text("Score: \(score)")
                .font(.headline)
            VStack(alignment: .leading) {
                if !firstSet.isEmpty {
                    Text("What is \(firstSet[currentQuestion]) x \(secondSet[currentQuestion])?")
                }
            }
            VStack {
                TextField("Your Answer", text: $userAnswer)
                    .keyboardType(.numberPad)
                
                Button("Check") {
                    checkAnswer()
                }
            }
        }
        .navigationTitle("Question \(currentQuestion + 1)")
    }
}
