
import SwiftUI

struct IMCResult: View {
    let weight:Double
    let height:Double
    var body: some View {
        VStack{
            Text("Tu resultado").font(.title).bold().foregroundColor(.white)
            InformationView(result: calculateIMC(weight: weight, height: height))
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundApp)
    }
}

struct InformationView:View{
    let result:Double
    var body: some View{
        let information = getResultIMC(result: result)
        VStack{
            Text(information.0).foregroundColor(information.2).font(.title).bold()
            Text("\(result, specifier: "%.2f")"  ).font(.system(size: 80)).bold().foregroundColor(.white)
            Text(information.1).foregroundColor(.white).font(.title2).padding(.horizontal, 20)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundComponent).cornerRadius(16).padding(16)
    }
}

func calculateIMC(weight:Double, height:Double)-> Double{
    let result = (weight / pow((height/100), 2))
    return result
}

func getResultIMC(result:Double)-> (String, String, Color){
    let title:String
    let description:String
    let color:Color
    
    switch result {
    case 0.00...19.99:
        title="Peso bajo"
        description="Estás por debajo del peso recomendado según el IMC"
        color = .yellow
    case 20.00...24.99:
        title="Peso Normal"
        description="Estás en el peso recomendado según el IMC"
        color = .green
    case 25.00...29.99:
        title="Sobrepeso"
        description="Estás por encima del peso recomendado según el IMC"
        color = .orange
    case 30.00...100:
        title="Obesidad"
        description="Estás por muy encima del peso recomendado según el IMC"
        color = .red
    default:
        title="ERROR"
        description="Ha ocurrido un error"
        color=Color.gray
            
    }
    
    return (title, description, color)
    
}


#Preview {
    IMCResult(weight: 80, height: 190)
}
