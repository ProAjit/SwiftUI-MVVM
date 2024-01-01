//
//  UserView.swift
//  SwiftUI_MVVM
//
//  Created by Ajit Satarkar on 20/11/23.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel = UserListViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.users ?? [], id: \.id) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.avatarURL ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                
                        } placeholder: {
                            Circle()
                                .foregroundColor(.teal)
                        }
                        .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(user.login?.capitalized ?? "")
                                .font(.headline)
                                .fontWeight(.heavy)
                            Text(user.url ?? "")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                    }
                }
                .listStyle(.plain)
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.teal)
                        .controlSize(.large)
                }
                
            }
            .navigationTitle("Users List")
        }
        .task {
            await viewModel.getUsers()
        }
        .alert(isPresented: $viewModel.shouldShowAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(viewModel.userError?.localizedDescription ?? "")
            )
        }
        
    }
    
}

#Preview {
    UserView()
}
