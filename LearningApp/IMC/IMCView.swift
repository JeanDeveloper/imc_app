//
//  IMCView.swift
//  LearningApp
//
//  Created by Jean Carlo Chunga Sandoval on 28/12/24.
//

import SwiftUI

struct IMCView: View {
    
    @State var gender:Int = 0
    @State var selectedHeight:Double = 100
    @State var age:Int = 18
    @State var weight:Int = 80
    
    var body: some View {
        VStack{
            HStack{
                ToggleButton(text: "Femenino", imageName: "heart.fill", gender: 0, selectedGender: $gender)
                ToggleButton(text: "Masculino", imageName: "star.fill", gender: 1, selectedGender: $gender)
            }
            HeightCalculator(selectedHeight: $selectedHeight)
            HStack{
                CounterButton(title: "Edad", counterNumber: $age)
                CounterButton(title: "Peso", counterNumber: $weight)
            }
            IMCCalculatorButton(weight: Double(weight), height: selectedHeight)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
        .toolbar{
            ToolbarItem(placement:.principal){
                Text("IMC Calculator").bold().foregroundColor(.white)
            }
        }
    }

}


struct ToggleButton:View {
    let text:String
    let imageName:String
    let gender:Int
    @Binding var selectedGender:Int

    var body: some View {
        let color = if(gender == selectedGender) {
            Color.backgroundApp
        } else {
            Color.backgroundSelected
        }

        Button(action: {
            selectedGender = gender
            
        }) {
            VStack{
                Image(systemName:imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height:100)
                    .foregroundColor(.white)
                InformationText(text: text)
                    
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(color)
        }
    }
}

struct InformationText:View {
    let text:String
    var body: some View {
        Text(text).font(.largeTitle).bold().foregroundColor(.white)
    }
}

struct TitleText:View {
    let text:String

    var body: some View {
        Text(text).font(.title2).foregroundColor(.gray)
    }
}

struct HeightCalculator: View {
    @Binding var selectedHeight:Double
    var body: some View {
        VStack {
            TitleText(text: "Altura")
            InformationText(text: "\(selectedHeight)cm")
            Slider(value: $selectedHeight, in:100...220, step:1).accentColor(.purple)
        }.frame(maxWidth:.infinity, maxHeight: .infinity).background(.backgroundComponent)
    }
}


struct CounterButton:View {
    let title:String
    @Binding var counterNumber:Int
    var body: some View {
        VStack{
            TitleText(text: title)
            InformationText(text: "\(counterNumber)")
            HStack{
                Button(action:{
                    if counterNumber > 0 {counterNumber-=1}
                }){
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "minus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                }
                Button(action:{
                    if counterNumber <= 99 {counterNumber+=1}
                }){
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }.frame(maxWidth:.infinity, maxHeight: .infinity).background(.backgroundComponent)
    }
}


struct IMCCalculatorButton: View {
    let weight:Double
    let height:Double
    var body: some View{
        NavigationStack{
            NavigationLink(
                destination: {IMCResult(weight: weight, height: height)}
            ){
                Text("Calcular").font(.title).bold().foregroundColor(.purple).frame(maxWidth: .infinity, maxHeight: 100).background(.backgroundComponent)
            }
        }
    }
}



#Preview {
    IMCView()
}


