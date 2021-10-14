//
//  ContentView.swift
//  UserConnectionsNoCoreData
//
//  Created by Jake King on 23/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var users = Array<User>()
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(users) { user in
                        NavigationLink(destination: UserDetailView(userId: user.id,
                                                                   allUsers: users)) {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                    .padding(.top,
                                             3)
                                Text(user.company)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom,
                                             3)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Users")
            .onAppear(perform: getUsers)
        }
    }
    
    func getUsers() {
        //create the URL to read
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        //create the URLRequest
        let request = URLRequest(url: url)
        
        //run the URLRequest
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error.")")
                return
            }
            
            //create the JSONDecoder
            let decoder = JSONDecoder()
            
            //modify the date decoding strategy
            decoder.dateDecodingStrategy = .iso8601
            
            //handle the response
            do {
                users = try decoder.decode([User].self,
                                            from: data)
                return
            } catch {
                print("Decoding failed: \(error.localizedDescription)")
            }
            
            print("Error: \(error?.localizedDescription ?? "Unknown error.")")
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
