//
//  UserDetailView.swift
//  UserConnectionsNoCoreData
//
//  Created by Jake King on 23/08/2021.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    let allUsers: Array<User>
    
    init(userId: UUID,
         allUsers: Array<User>) {
        self.allUsers = allUsers
        
        if let matchedUser = allUsers.first(where: { $0.id == userId }) {
            self.user = matchedUser
        } else {
            fatalError("Missing \(userId).")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Personal Details")) {
                HStack(alignment: .top) {
                    Text("Age")
                        .font(.body.bold())
                    Text("\(user.age)")
                }
                
                HStack(alignment: .top) {
                    Text("Employer")
                        .font(.body.bold())
                    Text(user.company)
                }
                
                HStack(alignment: .top) {
                    Text("Address")
                        .font(.body.bold())
                    Text(user.address)
                }
                
                HStack(alignment: .top) {
                    Text("Email")
                        .font(.body.bold())
                    Text(user.email)
                }
                
                HStack(alignment: .top) {
                    Text("Status")
                        .font(.body.bold())
                    Text(user.isActive ? "Active" : "Inactive")
                }
                
                HStack(alignment: .top) {
                    Text("Tags")
                        .font(.body.bold())
                    
                    VStack(alignment: .leading) {
                        ForEach(user.tags,
                                id: \.self) { tag in
                            Text("\(tag)")
                        }
                    }
                }
            }
            
            Section(header: Text("About \(user.name.components(separatedBy: " ").first ?? "User")")) {
                Text(user.about.trimmingCharacters(in: .whitespacesAndNewlines))
                    .padding(.top,
                             3)
                    .padding(.bottom,
                             3)
            }
            
            Section(header: Text("\(user.name.components(separatedBy: " ").first ?? "User")'s Connections")) {
                ForEach(user.friends) { friend in
                    NavigationLink(destination: UserDetailView(userId: friend.id,
                                                               allUsers: allUsers)) {
                        VStack(alignment: .leading) {
                            Text(friend.name)
                            Text(getFriendCompany(friendId: friend.id))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(user.name)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getFriendCompany(friendId: UUID) -> String {
        if let matchedUser = allUsers.first(where: ({ $0.id == friendId })) {
            return matchedUser.company
        } else {
            fatalError("Missing \(friendId).")
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(userId: UUID(),
                       allUsers: Array<User>())
    }
}
