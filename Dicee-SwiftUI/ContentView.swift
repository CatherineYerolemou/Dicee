//
//  ContentView.swift
//  Dicee-SwiftUI
//
//  Created by Catherine Yerolemou on 25/10/2023.
//  Updated by Catherine Yerolemou on 09/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var numberOfDice = 1
    @State private var diceValues: [Int] = [1]
    
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                //Heading
                Text("Dicee")
                    .font(.system(size: 60, design: .serif)
                        .lowercaseSmallCaps())
                    .foregroundStyle(.black)
                    .shadow(radius: 10, x: 0, y: 10)
                Spacer()
                
                //Display die
                HStack {
                    ForEach(0..<numberOfDice, id: \.self) { index in
                        diceView(value: $diceValues[index])//Update dice value array
                    }
                }
                Spacer()
                
                HStack {
                    Button("Remove Dice", systemImage: "minus.circle.fill") {
                        numberOfDice = max(1, numberOfDice - 1)//Update number of dice
                        updateDiceValues()
                    }
                    .disabled(numberOfDice == 1)
                    .padding()
                    
                    Button(action: {
                        rollAllDice()
                    }) {
                        Text ("ROLL ALL")
                            .font(.system(size: 25, design: .serif)
                                .bold())
                    }
                    .buttonStyle(.bordered)
                    
                    
                    Button("Add Dice", systemImage: "plus.circle.fill") {
                        numberOfDice = min(5, numberOfDice + 1)//Update number of dice
                        updateDiceValues()
                    }
                    .disabled(numberOfDice == 5)
                    .padding()
                }
                .shadow(radius: 10, x: 0, y: 10)
                .padding()
                .labelStyle(.iconOnly)
                .font(
                    .largeTitle
                        .lowercaseSmallCaps())
                Spacer()
            }
            .padding()
            .tint(.black)
        }
        .onAppear {
            updateDiceValues()
        }
    }
    
    
    private func updateDiceValues() {
        if diceValues.count < numberOfDice {
            // Add new dice, keep existing values
            for _ in 0..<(numberOfDice - diceValues.count) {
                diceValues.append(1)
            }
        } else if diceValues.count > numberOfDice {
            // Remove dice, keep existing values
            diceValues = Array(diceValues.prefix(numberOfDice))
        }
    }
    
    
    private func rollAllDice() {
        withAnimation {
            //replace values in array with new dice values
            diceValues = diceValues.map { _ in
                Int.random(in: 1...6)
            }
        }
    }
    
}


struct diceView: View {
    
    @Binding var value: Int
    
    var body: some View {
        Button(action: {
            withAnimation {
                value = Int.random(in: 1...6)
            }
        }) {
            Image(systemName: "die.face.\(value).fill")
                .resizable()
                .shadow(radius: 0, x: 2, y: 7)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 150, maxHeight: 150)
                .foregroundStyle(.black, .white)
        }
    }

}


#Preview {
    ContentView()
}

