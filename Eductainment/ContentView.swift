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
            } else {
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
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                currentQuestion == questionAmount - 1 ? endGame() : nextQuestion()
            }
        } message: {
            Text(alertMessage)
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Play Again", action: resetGame)
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
    
    func generateNumbersArray(max: Int, amount: Int) -> [Int] {
        var numbers = [Int]()
        for _ in 1...max {
            numbers.append(Int.random(in: 2...12))
        }
        return numbers
    }
}

#Preview {
    ContentView()
}
