//
//  VaticanView.swift
//  iTravel
//
//  Created by Franklyn Chiemeka Ekoh on 01/05/24.
//

import SwiftUI


struct VaticanView: View {
    @State var VaticanMuseum: String = """
    􀎪The Vatican Museums are the national museum of the Vatican City, in Rome.

    Founded by Pope Julius II in the sixteenth century, occupy much of the vast courtyard of the Belvedere and are one of the largest art collections in the world, since they exhibit the huge collection of works of art accumulated over the centuries by the popes: the Sistine Chapel and the papal apartments frescoed by Michelangelo and Raphael are part of the works that visitors can admire on their way. Although the museums are located entirely in Vatican territory, their entrance is located in Italian territory, in Viale Vaticano 6 in Rome.
    
    
    􀉉 Opening days and times 2024
    From Monday to Saturday 08.00 a.m. – 07.00 p.m. (final entry 05.00 p.m.)  From 1 March On Fridays and Saturdays extended opening hours until 08.00 p.m. (final entry 06.00 p.m.)  Every last Sunday of the month 09.00 a.m. – 02.00 p.m. (final entry 12.30 p.m.) Free entry – Possibility of guided
    """
    @State var Page: String = "Vatican Museum"
    var body: some View {
        NavigationStack{
            ScrollView{
                Image("Vatican_image")
                Text(VaticanMuseum).padding()
            }// MARK: END SCROLLVIEW
            .navigationTitle(Page)
        /*
         .navigationBarItems(
        
                 leading: NavigationLink(destination: PreviousView()){
                 HStack {
                 Image(systemName: "chevron.left")
                 Text("Back")
                 }
                 }
            
                 trailing: NavigationLink(destination: ArtView()) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                })
                 */
        }// MARK: END NAVSTACK
    }
}

#Preview {
    VaticanView()
}
