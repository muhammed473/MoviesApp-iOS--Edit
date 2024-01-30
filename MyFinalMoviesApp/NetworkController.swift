//
//  NetworkController.swift
//  MyFinalMoviesApp
//
//  Created by muhammed dursun on 15.11.2023.
//

import Foundation

import Network

final class NetworkController {
    
    
        static let shared = NetworkController()
        
        private let queue = DispatchQueue.global()
        // internet bağlantısı her değiştiğinde kontrol edicez. Arka plan iş parçacığı olarak düşün.
        
        private let screen : NWPathMonitor
        // NWPathMonitor : Ağ yolu monitörü sınıfı. Ağ değişikliklerini izlemek ve bunlara tepki vermek için kullandığımız
        //                 bir gözlemci sınıfıdır.
        
        /* public var isConnected : Bool  ==>
         
                - Cihazın bağlı olup olmadığını kontrol etmek için genel bir dalga  isteyeceğiz
                                                 
                - Şuanda herkese açık genel kapsamın bunu güncelleyebilmesini İSTEMİYORUZ.
               
                - Bu yüzden bu kodu aşağıdaki gibi HERKESİN OKUYABİLECEĞİ ŞEKİLDE HERKESE AÇIK OLDUĞUNU SÖYLEYECEĞİZ.
                                            
                - ANCAK yalnız bu  sınıf oluşturmak istediğimiz SONRAKİ ayarlayıcının ÖZEL OLDUĞUNU söyleyerek DEĞERİNİ
                  GÜNCELLEYEBİLİR.
        */
        
        public private(set) var isConnected : Bool = false
        
        public private(set) var connectionType : ConnectionType = .unknown // Varsayılan olarak bilinmeyenmiş.
        
        enum ConnectionType {
            case wifi
            case cellular
            case ethernet
            case unknown // unknown = bilinmeyen
        }
        
        private init() {
            self.screen = NWPathMonitor()
        }
        
        public func startMonitoring() { //  Ağ değişimini izlemeyi Başlatıyorum :
            
            screen.start(queue: queue)
            screen.pathUpdateHandler = // pathUpdateHandler : Yol güncelleme işleyicisi
            {
              [weak self]  (path) in
                // Eğer yol ŞİMDİ karşılanırsa TUTULAN BİR DÖNGÜYE NEDEN OLUR bu yüzden
                // weak self 'i ( zayıf özü ) buraya koyduk
                
              //  self?.isConnected = path.status == .satisfied // satisfied = bağlı
                self?.isConnected = path.status != .unsatisfied
                // Şimdi bağlantı tipini ayarlıyoruz :
                self?.getConnectionType(path: path)
                
                /*
                 path.usesInterfaceType = Yolu kullanan bağlantıların belirli bir ARAYÜZ TİPİ üzerinden trafik gönderip
                                          gönderemeyeceğini kontrol eder.
                 - Yolun üzerinde arayüz tipini kullanan bir fonksiyon var ve BURDA BİRDEN FAZLA ARAYÜZ TİPİ VAR.Bunlar :
                   cellular, loopback, other,wifi, wiredEthernet = hücresel bağlantı ,geridöngü,diğer,wifi,kabloluEthernet
                
                 */
                
                // print(self?.isConnected ?? "N/A")
            }
            
        }
        
        
        public func stopMonitoring() {
            
            screen.cancel()
            
        }
        
        private func getConnectionType (path : NWPath ) { // Bağlantı tipini al.
            
            if path.usesInterfaceType(.wifi) { // Eğer yol wifi kullanıyor ise
                connectionType = .wifi
            }
            else if path.usesInterfaceType(.cellular){
                connectionType = .cellular
            }
            else if path.usesInterfaceType(.wiredEthernet){
                connectionType = .ethernet
            }
            
            else {
                connectionType = .unknown
            }
            
            
        }
        
        
    }
    
    

