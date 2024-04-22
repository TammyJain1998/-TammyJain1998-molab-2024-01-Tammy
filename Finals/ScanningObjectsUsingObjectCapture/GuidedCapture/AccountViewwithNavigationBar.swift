//
//  AccountViewwithNavigationBar.swift
//  GuidedCapture
//
//  Created by Tamanna Jain on 4/15/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct AccountViewwithNavigationBar: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    var body: some View {
        ZStack(alignment: .bottom) {
            AccountView()
            HomeButtonView2()
            // Depending on your layout, you might need to adjust the alignment or positioning
        }
    }
}

#Preview {
    AccountViewwithNavigationBar()
}
