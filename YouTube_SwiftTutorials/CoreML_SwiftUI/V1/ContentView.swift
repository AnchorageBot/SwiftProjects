//
// VixData
// ContentView.swift
//
// Created on 8/5/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/*

Abstract:
 
This SwiftUI App will predict the value of the Vix Index by taking into account Yahoo Finance data consisting of:
 
 * Date  (date)
 * Open  (integer)
 * High  (integer)
 * Low   (integer)
 * Close (integer)

 ... and then provides a prediction of a Vix closing value for the next day.
 
 This SwiftUI app incorporates a mathematical model (24_07_VixData_Auto.mlmodel), made with Create ML which uses machine learning, into the app using Apple's CoreML
 
*/

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    @State private var open = ""
    @State private var high = ""
    @State private var low = ""
    @State private var close = ""
    
    @State private var predictionResult = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Data")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Open", text: $open)
                        .keyboardType(.decimalPad)
                    TextField("High", text: $high)
                        .keyboardType(.decimalPad)
                    TextField("Low", text: $low)
                        .keyboardType(.decimalPad)
                    TextField("Close", text: $close)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Predict VIX") {
                        calcVix()
                    }
                }
                
                if !predictionResult.isEmpty {
                    Section(header: Text("Prediction")) {
                        Text(predictionResult)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("VIX Predictor")
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calcVix() {
        guard let openValue = Double(open),
              let highValue = Double(high),
              let lowValue = Double(low),
              let closeValue = Double(close) else {
            alertTitle = "Invalid Input"
            alertMessage = "Please enter valid numeric values for Open, High, Low, and Close."
            showAlert = true
            return
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try _24_07_VixData_Auto(configuration: config)
            
            let input = _24_07_VixData_AutoInput(
                Date: date,
                Open: openValue,
                High: highValue,
                Low: lowValue,
                Close: closeValue
            )
            
            let prediction = try model.prediction(input: input)
            
            predictionResult = String(format: "Predicted VIX: %.2f", prediction.AdjVix)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating a VIX estimate: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
