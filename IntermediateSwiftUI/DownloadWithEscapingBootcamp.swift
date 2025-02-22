//
//  DownloadWithEscapingBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 22.02.2025.
//

import SwiftUI

//Combine sayfasına taşındı
//struct PostModel: Identifiable , Codable{
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}


//@escaping kaçış dmektir bazı fontkisonlarda veri döndürmek zaman aldıdğından bperformans için kullanmamız gerekir

//[weak self] oldukça önemli çünlkü asenktron kod yazıyoruz dnemek için 43.satırdali Dispath kodu silinip self? -> self yapınca Background thread kritik uyarısı verdiği görülür

//MARK: getPosts() motudu uzun ve konuyu açıklamak için oluşturulmuştur json data olarak internteen bir adet data indirildi
//MARK: getPosts2() metodu daha profseyonel ve @escaping kullnılarak kaçış karakterli daha persformasınlı ve bir adet veri değil birden yaklşaık 100 tane veri indirilmiştir farkı olarak 37.satırdali [PostModel] parantezileirne dikkat et.


class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        //getPosts() -> amele yöntemi
        getPosts2()
        
    }
    
    func getPosts2(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}

        downloadData(fromURL: url) { returnedData in
            if let data = returnedData {
                guard let newPosts =  try? JSONDecoder().decode([PostModel].self, from: data) else {return}
                //self.posts.append yaptıgın zaman thread olur bu yüzden zayıf benlik -> [weak self] yapman gerekir
                DispatchQueue.main.async { [weak self] in //işlemden çıkıldıgı zaman sorguyu iptal etmek için
                    self?.posts = newPosts
                }
            }
        }
    }
    
    func getPosts(){
        
        //Api için url i belirledik
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {return}
        
        //data -> datadır
        //response -> gelen çağırnın güvenli veya iyi olup olmadıgıdır bu değerler 100 200 300 400 500 arasonda değişir
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //data var mı diye kontrol ettik
            guard let data = data else {
                print("Error -> No Data")
                return
            }
            
            //response var mı ve gücenli mi diye baktık
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            //200 - 300 arası bizim için iyi bir değerdir bu değer arasında olması gerekir
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx , but is \(response.statusCode)")
                return
            }
            
            print("SUCCESFULLY DOWNLOADED DATA")
            print(data)
            
            //------
            let jsonString = String(data: data, encoding: .utf8) // JSON formatına çevirdik
            print(jsonString)
            //--- bu kısım JSON datayı konsolda görmek için
            
            guard let newPost =  try? JSONDecoder().decode(PostModel.self, from: data) else {return}
            //self.posts.append yaptıgın zaman thread olur bu yüzden zayıf benlik -> [weak self] yapman gerekir
            DispatchQueue.main.async { [weak self] in //işlemden çıkıldıgı zaman sorguyu iptal etmek için
                self?.posts.append(newPost)
            }
            
            
        }.resume() // resume demek URLSessionu başlatmak içindir resume() demez isek oturum başlatılmaz
        
        
        
        
        
    }
    
    //Yukarıdaki kod web sitesine gidip json datayı alıp geri döndüğü zaman bize bir çıktı verir ancak bizim bazı durumlarda veriyi beklemeden çıkış yapabilmemiz gerekir bu yüzden escaping yapmmaız lazım
    func downloadData(fromURL url : URL , completionHandler : @escaping (_ data: Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //data var mı diye kontrol ettik
            guard let data = data ,
            error==nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300  else {
                print("Error Downkoadinf data")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }.resume()
    }
    
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var viewModel = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.title2)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity , alignment: .leading)
            }
        }
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
