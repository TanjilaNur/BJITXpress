//
//  ShowLoadingIndicator.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 17/5/23.
//

import SwiftUI

struct ShowLoadingIndicator: View {
    var body: some View {
        Text("Loading...")
            .frame(width: 120, height: 120, alignment: .center)
            .background(.white)
    }
}

struct ShowLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ShowLoadingIndicator()
    }
}
