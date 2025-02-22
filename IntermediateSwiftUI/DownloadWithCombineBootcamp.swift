//
//  DownloadWithCombineBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 22.02.2025.
//

//MARK: SENARYO :
/*
        1. Aylık paket alımı için abone olmak
        2.Pkaetin hazırlanması
        3 . paketi teslim almak
        4. pajetin hasarlı olup olmadıgına bakmak
        5. içeriğ, kotnrol etmek
        6.paketi kullanmak
        7.bu paket süresi her hangi bir zamanda iptal edilbilir
 */

import SwiftUI
import Combine

struct PostModel: Identifiable , Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts : [PostModel] = []
    var cancallable = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
  
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        //Publisher yayıncı demektir belirli süreler ile datayı yayınlar
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // background threade alındı
            .receive(on: DispatchQueue.main) // ana threade alındı
            .tryMap { data , response -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { completion in
                print("COMPLETION : \(completion) ")
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancallable) // -> iptal edebilmek için 

        
    }
    
   
    
    
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var viewModel = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    DownloadWithCombineBootcamp()
}
