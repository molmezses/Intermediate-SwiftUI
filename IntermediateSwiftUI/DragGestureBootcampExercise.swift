//
//  DragGestureBootcampExercise.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 15.02.2025.
//

import SwiftUI

struct DragGestureBootcampExercise: View {
    
    // MySignUpView sayfasının ekranın altında başlaması  için
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    
    @State var currentDragOffsetY: CGFloat = 0
    
    //Belirli bir mesafeden sonra bırkaılrısa yukaırda sabit kalsın
    @State var endingOffSetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y:endingOffSetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring){
                                //istediğin yere haraket ettirmek için
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring){
                                if currentDragOffsetY < -300{
                                    //belirli bir yüksekliğe çıkmadıysa tekrardan başlangıç konumıuna getir
                                    endingOffSetY = -startingOffsetY
                                }else if endingOffSetY != 0 && currentDragOffsetY > 300{
                                    //aşağı indirirekren belirli bir mesafe indirince en aşağı indir
                                    endingOffSetY = 0
                                }
                                //bırakıldıgı zaman tekrar eski haline dönmesi için -> yukarı çıkarken
                                currentDragOffsetY = 0
                            }
                        })
                )
            
            VStack{
                Text("\(currentDragOffsetY)")
                Spacer()
            }
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}

#Preview {
    DragGestureBootcampExercise()
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the decription for our app. This is my favourite SwiftUI course and I recoemmend to all of my firens to try it out")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("CREATE AN ACOOUNT")
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.indigo)
                .mask(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .foregroundStyle(.indigo)
    }
}
