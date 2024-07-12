//
//  ContentView.swift
//  Eductainment
//
//  Created by Nicholas Johnson on 7/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showGame = false
    @State private var maxNumber = 12
    @State private var questionAmount = 5
    private var questionAmounts: [Int] = [5, 10, 15]
    @State private var firstSet: [Int] = [2, 2, 2, 2, 2, 2]
    @State private var secondSet: [Int] = [2, 2, 2, 2, 2, 2]
    @State private var currentQuestion = 0
    @State private var userAnswer = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var gameOver = false
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            if !showGame {
                SettingsView(firstSet: $firstSet, secondSet: $secondSet, showGame: $showGame)
            } else {
                GameView(
                    score: $score,
                    currentQuestion: $currentQuestion,
                    firstSet: $firstSet,
                    secondSet: $secondSet,
                    userAnswer: $userAnswer,
                    showAlert: $showAlert,
                    alertTitle: $alertTitle,
                    alertMessage: $alertMessage
                )
            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                currentQuestion == questionAmount - 1 ? endGame() : nextQuestion()
            }
        } message: {
            Text(alertMessage)
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("You scored \(score) out of \(questionAmount). Would you like to play again?")
        }
    }
    
    func endGame() {
        gameOver = true
    }
    
    func resetGame() {
        gameOver = true
        userAnswer = ""
        score = 0
        currentQuestion = 0
        showGame = false

    }
    
    func nextQuestion() {
        currentQuestion += 1
        userAnswer = ""
    }
    
    
}

#Preview {
    ContentView()
}



