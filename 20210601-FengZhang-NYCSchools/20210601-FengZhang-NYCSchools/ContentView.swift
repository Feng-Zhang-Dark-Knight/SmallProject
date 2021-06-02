//
//  ContentView.swift
//  20210601-FengZhang-NYCSchools
//
//  Created by Thales on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var score = SATScore(school: "", math: "", writing: "", reading: "")
    @State var showScore = false
    @State var dragState = CGSize.zero
    
    var body: some View {
        ZStack {
            HomeBackgroundView(showScore: $showScore)
            
            List(viewModel.newYorkSchools.schools) { school in
                SchoolView(school: school)
                    .padding()
                    .padding(.vertical, 5)
                    .onTapGesture {
                        print("Tapped!!!!!")
                        self.score = viewModel.schoolSAT.getSchoolScore(for: school)
                        showScore = true
                    }
            }
            .offset(y: showScore ? -450 : 0)
            .rotation3DEffect(Angle(degrees: showScore ? Double(dragState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(showScore ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
            
            ScoreView(scores: self.score, showScore: $showScore)
                .background(Color.black.opacity(0.001))
                .offset(y: showScore ? 0 : screen.height)
                .offset(y: dragState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showScore.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragState = value.translation
                    }
                    .onEnded { value in
                        if self.dragState.height > 50 {
                            self.showScore = false
                        }
                        self.dragState = .zero
                    }
                )
        }

    }
    
}


struct SchoolView: View {
    var school: School
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(school.name)
                .font(.headline)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
            Text(school.location)
                .font(.subheadline)
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
        }
    }
}


struct ScoreView: View {
    var scores: SATScore
    @Binding var showScore: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Average SAT Score")
                    .font(.body)
                
                Text("Math:     \(scores.math)")
                    
                Text("Writing: \(scores.writing)")
                    
                Text("Reading: \(scores.reading)")
                    
            }
            .onTapGesture {
                self.showScore = false
            }
            .frame(maxWidth: 500)
            .frame(height: 300)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 30)
    }
}




struct HomeBackgroundView: View {
    @Binding var showScore: Bool
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: showScore ? 30 : 0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
