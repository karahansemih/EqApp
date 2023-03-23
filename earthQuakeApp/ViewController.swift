//
//  ViewController.swift
//  earthQuakeApp
//
//  Created by Semih Karahan on 18.02.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var baslikLabel: UILabel!
    @IBOutlet weak var tv: UITableView!
    
    var sehir1 = ""
    var sehirTv = [String]()
    var tarihTv = [String]()
    var saatTv = [String]()
    var siddetTv = [String]()
    var derinlikTv = [String]()
    var latTv = [String]()
    var lngTv = [String]()

    var array = [String]()
    var contents = String()
    var dictArray = [String]()
    var keyArray = ["tarih", "saat", "enlem", "boylam", "derinlik", "bos1", "siddet", "bos2", "gereksiz", "sehir", "durum"]
    var fullStack = [String : String]()
    var allData = [[String : String]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tv.delegate = self
        tv.dataSource = self

        self.baslikLabel.text = "Son 30 deprem"
        DispatchQueue.main.async { [self] in
            self.getEqData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sehirTv.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Tvc
        cell.sehir.text = sehirTv[indexPath.row]
        cell.zaman.text = tarihTv[indexPath.row]
        cell.siddet.text = "Şiddet: \(siddetTv[indexPath.row])"
        cell.derinlik.text = "Derinlik: \(derinlikTv[indexPath.row])"
        cell.lat.text = "Enlem: \(latTv[indexPath.row])"
        cell.lng.text = "Boylam: \(lngTv[indexPath.row])"
        
        return cell
    }
    
    func getEqData(){
        var request = URLRequest(url: URL(string: "http://www.koeri.boun.edu.tr/scripts/sondepremler.asp")!)
        request.httpMethod = "GET"
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { [self] data,response,error in
            if let data = data {
                let contents = String(data: data, encoding: .ascii)!
                //print(contents)
                
                let conArr = contents.components(separatedBy: "<pre>")
                let conArr2 = conArr[1].components(separatedBy: "</pre")
                // Net bir şeilde her bir depremin datasının ilk defa alındığı değişken    //print(conArr2[0])
                let list1 = conArr2[0].components(separatedBy: "--------------")
                let lineBylineEqList = list1[2].components(separatedBy: "\r\n")


                //print(lineBylineEqList[1])
                var sayi1 = 1
                let denemeNumber = Range(1...90)
                for idn in denemeNumber{
                    let deneme = lineBylineEqList[idn].components(separatedBy: " ")
                    let listeCount = deneme.count - 1
                    let number2 = Range(0...listeCount)
                    dictArray.removeAll()
                    for i2 in number2{
                        let deger = deneme[i2]
                        if deger != "" {
                            self.dictArray.append(deger)
                        }
                    }
                    //print(sayi1)
                    //print(dictArray)
                    sayi1 += 1
                    if dictArray.count == 11 {
                        dictArray[8] = dictArray[8] + dictArray[9]
                    }

                    if dictArray.count == 11{
                        fullStack = Dictionary(uniqueKeysWithValues: zip(keyArray, dictArray))
                        //print("11 \(fullStack)")
                        allData.append(fullStack)

                    } else if dictArray.count == 12 {
                        dictArray.removeLast()
                        fullStack = Dictionary(uniqueKeysWithValues: zip(keyArray, dictArray))
                        //print("12 \(fullStack)")
                        allData.append(fullStack)
             
                    } else if dictArray.count == 10 {
                        keyArray.remove(at: 8)
                        fullStack = Dictionary(uniqueKeysWithValues: zip(keyArray, dictArray))
                        //print("10 \(fullStack)")
                        allData.append(fullStack)
                        keyArray.insert("ilce", at: 8)

                    } else {
                        print(error as Any)
                    }
                }
            }
            print(allData)
            
            for each in allData{
                if let sehir = each["sehir"]{
                    self.sehirTv.append(sehir)
                }
                if let tarih = each["tarih"]{
                    self.tarihTv.append(tarih)
                }
                if let saat = each["saat"]{
                    self.saatTv.append(saat)
                }
                if let siddet = each["siddet"]{
                    self.siddetTv.append(siddet)
                }
                if let derinlik = each["derinlik"]{
                    self.derinlikTv.append(derinlik)
                }
                if let lat = each["enlem"]{
                    self.latTv.append(lat)
                }
                if let lng = each["boylam"]{
                    self.lngTv.append(lng)
                }
            }


        }.resume()
    }
}

