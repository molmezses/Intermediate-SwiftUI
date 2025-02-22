//
//  EscapingBootcamp.swift
//  IntermediateSwiftUI
//
//  Created by Mustafa Ölmezses on 22.02.2025.
//

import SwiftUI


/*
 Senaryo :
 
 İnternetten veri indirmek gibi işlemlerde veya veritabanına çağrı yağtığımız işlemlerde bu verileri almak için fonksiyonlar olışturacağız ancak bu fonskiyonlar hemen geri dönmeyecek
    
 sunucuya git , veriyi al , veriyi uygulamaya geri getir
 
 böyleyelikle bu fsonkiyondan hemen geri dönemiycez , hemen geri dönmek yerine asenkron kodu ele almamız gerekiyor
 
 bu yüzden var olan fsonkiyonun içinden bir başaka fonskiyon oluşturularak çağrı bittiğimi zaman o fonskiyonu başlatabiliiz
 

 
 */

class EscapingViewModel : ObservableObject {
    
    @Published var text : String = "Hello"
    
    func getData(){
//        downloadData2 { data in
//            text = data
//        }
        
        
        //self demek zroundasın ama kullanıcı sayafa gelip tekrar çıktıgı zaman 3 saniyelik veri indirmesini iptal etmen gerekir çünkü kullanucuların ona ihtiyacı artık yoktur o yüzden self? demen ve [weak self] -> demen gerekir
        
        
//        downloadData3 { [weak self] data in
//            self?.text = data
//        }
        
//        sadece String değil birden çok veri döncekse bir struct yapısı olarka tanımnlayabilirsin
        
        downloadData4 {  [weak self] result in
            self?.text = result.data
        }
        
        
    }
    
    func downloadData() -> String{
        return "New Data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void){
        completionHandler("NewData")
    }
    
    //veritanındaki işlerimiz bie 2 3 saniye sonra geri döndürüyorsa üstteki kod hata verir bizim kaçmamız gerekir
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ){
            completionHandler("NewData")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ){
            let result = DownloadResult(data: "New Data")
            completionHandler(result)
        }
    }
}

struct DownloadResult{
    let data: String
}


struct EscapingBootcamp: View {
    
    @StateObject var viewModel = EscapingViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                viewModel.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
