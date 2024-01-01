//
//  UserListViewModel.swift
//  SwiftUI_MVVM
//
//  Created by Ajit Satarkar on 20/11/23.
//

import Foundation

@MainActor
final class UserListViewModel: ObservableObject {
    
    @Published private(set) var users: [UserModel]?
    @Published private(set) var userError: UserError?
    @Published var shouldShowAlert = false
    @Published var isLoading = true
    
    func getUsers() async {
        //sleep(UInt32(3.0))
        do {
            self.users = try await WebService.getUsersData()
            self.isLoading = false
        } catch(let error) {
            userError = UserError.custom(error: error)
            shouldShowAlert = true
            isLoading = false
        }
    }
}
