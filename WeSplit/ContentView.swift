//
//  ContentView.swift
//  WeSplit
//
//  Created by Maximilian Berndt on 2023/03/06.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    var totalAmountPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var currencyIdentifier: String {
        return Locale.current.currency?.identifier ?? "USD"
    }
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: currencyIdentifier)
    }
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: currencyFormat
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(
                        grandTotal,
                        format: currencyFormat
                    )
                } header: {
                    Text("Grand Total")
                }
                Section {
                    Text(
                        totalAmountPerPerson,
                        format: currencyFormat
                    )
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
