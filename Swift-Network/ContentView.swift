//
//  ContentView.swift
//  Swift-Network
//
//  Created by Bekir Berke Yılmaz on 2.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    @State private var userName = ""
    var body: some View {
        VStack(spacing: 20){
            AsyncImage(url: URL(string:user?.avatarUrl ?? "")){image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundStyle(.secondary)
            }.frame(width: 120, height: 120)
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            Text(user?.bio ?? "Bio placeholder")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            do{
            user = try await getUser()
            }catch GHError.invalidURL{
                print("Invalid URL")
            }catch GHError.invalidData{
                print("Invalid Data")
            }catch GHError.invalidResponse{
                print("Invalid Response")
            }catch{
                print("Unexpected Error")
            }

        }
    }
}

#Preview {
    ContentView()
}
