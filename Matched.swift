//
//  MatchGeometry.swift
//  learning
//
//  Created by Bora Erdem on 18.08.2022.
//

import SwiftUI

struct Rectangle: Identifiable {
    var id = UUID().uuidString
}

var rects : [Rectangle] = [
//Rectangle() * 20
]

struct MatchGeometry: View {
    
    @State var show: Bool = false
    @State var curIndex: Int = .init()
    @State var appear = false
    @Namespace var namespace
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 16)], spacing: 16) {
                        ForEach(rects.indices) { index in lazyItemRectangle(index: index)}
                    }
                    .padding()
                }
                .navigationTitle("Matched")
            }
            if show{
                ScrollView(showsIndicators: false){
                    detailRectangle
                    detailTitle
                    detailText
                }
                .ignoresSafeArea()
                .background(appear ? .white : .clear)
                .onDisappear { appear = false}
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { withAnimation {appear = true} }
                }
            }
        }
    }
}

struct MatchGeometry_Previews: PreviewProvider {
    static var previews: some View {
        MatchGeometry()
    }
}

extension MatchGeometry{
    private var detailRectangle: some View {
        CustomRectangle(corners: [.bottomLeft,.bottomRight], radius: 30)
            .fill(.red)
            .onTapGesture(perform: {
                show.toggle()
            })
            .animation(.spring(response: 0.2, dampingFraction: 1))
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            .matchedGeometryEffect(id: rects[curIndex].id, in: namespace, properties: .frame, anchor: .center)

    }
    private var detailTitle: some View {
        Text("Matched Geometry")
            .font(.system(size: 55).bold())
            .padding(.horizontal)
            .offset(y: appear ? 0 : -30)
            .opacity(appear ? 1 : 0)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var detailText: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum volutpat neque et nulla commodo tincidunt. Suspendisse semper purus est, sed convallis turpis condimentum in. Vivamus faucibus eget massa consequat molestie. Vivamus id magna lorem. Nullam vulputate sed arcu nec tincidunt. Aenean imperdiet condimentum purus sed ornare. Donec ut pellentesque libero. Integer scelerisque posuere urna et rhoncus. Etiam eros mauris, efficitur ut elit semper, gravida eleifend turpis. Curabitur rutrum odio id arcu pretium, ornare ultrices mi ultrices.")
            .padding(.horizontal)
            .padding(.top,-10)
            .foregroundColor(.secondary)
            .offset(y: appear ? 0 : -30)
            .opacity(appear ? 1 : 0)
        
    }
    @ViewBuilder func lazyItemRectangle(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.red)
                .frame(height:150)
                .animation(.spring(response: 0.2, dampingFraction: 1))
                .matchedGeometryEffect(id: rects[index].id, in: namespace, properties: .frame, anchor: .center)
                .onTapGesture {
                    curIndex = index
                    show.toggle()
                    
                }
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 4)

        
    }
}
