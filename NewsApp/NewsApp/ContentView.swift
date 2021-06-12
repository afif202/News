//
//  ContentView.swift
//  NewsApp
//
//  Created by Afif on 12/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home()
                .navigationBarTitle("News")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View{
    
    @ObservedObject var Books = NewsApi()
    @State var show = false
    @State var url = ""
    var body: some View{
        List(Books.data){i in
            HStack{
                if i.image != ""{
                    WebImage(url: URL(string: i.image)!)
                    
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120,height: 170)
                        .background(Image("Loader").resizable().aspectRatio(contentMode: .fill).frame(width: 60, height: 30))
                        .cornerRadius(10)
                }else{
                    Image("Loader").resizable().frame(width: 120, height: 170).cornerRadius(10)
                }
                
                VStack(alignment: .leading,spacing : 10){
                    Text(i.title).fontWeight(.bold)
                    Text(i.description).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
                }
            }
        }
    }
}