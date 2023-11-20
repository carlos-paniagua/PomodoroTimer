//
//  Aquarium.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/14.
//

import SwiftUI

struct Aquarium: View {
    @State private var backbutton = false
    
    var body: some View {
        VStack{
            
            
            //            GeometryReader{proxy in}
            HStack{
                
                Button{
                    // ボタンが押された時のアクションを追加
                    backbutton = true
                }label:{
                    Image(systemName: "chevron.left")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background{
                            Circle()
                                .fill(Color("White"))
                        }
                }
                .navigationDestination(isPresented: $backbutton) {Home()}
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .padding() // ボタンの外側の余白を調整
                Spacer()
            }
            
            Spacer() // 左側に余白を作成

        }
        .padding()
        .background{
            Color("Blue")
                .ignoresSafeArea()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}






