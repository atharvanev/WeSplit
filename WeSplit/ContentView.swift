//
//  ContentView.swift
//  WeSplit
//
//  Created by Atharva Nevasekar on 8/9/23.
//

import SwiftUI
struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfpeople = 2
    @State private var tipPercentage = 15
    @FocusState private var amountisFocused: Bool
    private var tip:Double{
        return checkAmount / 100.0 * Double(tipPercentage)
    }
    
    let tipPercentages = [0,10,15,20,25]
    
    var total: Double {
        let peopleCount = Double(numberOfpeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandtotal = checkAmount+tipValue
        
        let amountPerPerson = grandtotal/peopleCount
        return amountPerPerson
    }
    var dollarFormat:FloatingPointFormatStyle<Double>.Currency{
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
   

    var body: some View {
        
        NavigationView(){
            Form{
                Section{
                    TextField ("Amount",value:$checkAmount,format: dollarFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountisFocused)
                    Picker("Number of People",selection:$numberOfpeople){
                        ForEach(2..<100){
                            Text("\($0)")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages,id: \.self){
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Tip Amount")
                }
                Section{
                    Text("Check Amount")
                    Text(checkAmount,format: dollarFormat)
                    Text("Tip Amount")
                    Text(tip,format: dollarFormat)
                }header: {
                    Text("Check Details")
                }
                Section{
                    Text(total,format: dollarFormat)
                }header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement:.keyboard){
                    Spacer()
                    Button("Done"){
                        
                        amountisFocused = false
                    }
                }
            }
         }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()   
        }
    }
}
