//
//  TimerBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 23.02.2025.
//

import SwiftUI

struct TimerBootcamp: View {
    
    /*
        Timer nesnesini publish olarak yayına alırız every: 1 olarak her saniye yayın yapar on:.main kısmı hangi threadde olacağıdır main threadde yapmamızın amacı her saniye viewın güncellenmesidir .autoconnect() yaparak view yüklendiği anda timerı başlatırız yayınlarız (yayınlamaya başlanır)
     
     */
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate: Date = Date()
    
    
    /*Current Time
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // tarih eklemek için
        formatter.timeStyle = .medium // sadece saati göstrmek
        return formatter
    }
    */
    
    //CountDown
    /*
    @State var count : Int = 10
    @State var finishedText: String? = nil
    */
    
    //CountDown to Date
    /*
    @State var timeRemaining: String = ""
    let futuredDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date() //-> şu an ki güne + 1 gün ekledik
    
    func updateTimeRemaining(){
        let remaining = Calendar.current.dateComponents([.hour , .minute , .second] , from: Date() , to: futuredDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
     */
    
    //Page
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.teal , Color.indigo]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count, content: {
                Rectangle()
                    .foregroundStyle(.teal)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.black)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.indigo)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ??  "\(count)")
//            Text(timeRemaining)
//            Text("")
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundStyle(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
//                .padding()
        }
        .onReceive(timer) { value in
            
            withAnimation(.default){
                count = count == 5 ? 0 : count + 1
            }
            
            
            //updateTimeRemaining()
            
            //her saniye gçerli date i güncelledik
            //currentDate = value
            
            /*
            if count < 1 {
                finishedText = "wow!"
            }else{
                count -= 1
            }
             */
            
            
        }
    }
}

#Preview {
    TimerBootcamp()
}
