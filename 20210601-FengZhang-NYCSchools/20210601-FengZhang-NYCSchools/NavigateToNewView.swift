//
//  GoToNewView.swift
//  NYCSchools by Feng
//
//  Created by Thales on 6/1/21.
//

import SwiftUI

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("Back")   // this cause Layout Constraints conflict.
                    .navigationBarHidden(true)
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(false),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}


// if you use UIKit, then this extension can hide status bar.
//extension UIViewController {
//    func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//}
