//
//  HomeVM.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import UIKit
import CoreData
protocol HomeVMDelegates: class {
    func getWeather()
    func saveToDatabase()
}
class HomeVM {
    let callNetwork = Network.shared
    static let shared = HomeVM()
    weak var delegate: HomeVMDelegates?
    var lat:String? = "41.0020986952399"
    var lon:String? = "28.86055091173599"
    var showLoading = true
    var model: WeatherModel?
   
    let coreDataModel = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coreDataArray = [WeatherArray]()
    
    func getCoreDataCount() -> Int {
        return coreDataArray.count
    }
    func getCoreData(indexPath:IndexPath) -> WeatherArray {
        return coreDataArray[indexPath.row]
    }
    func removeCoreData(indexPath:IndexPath) {
        coreDataArray.remove(at: indexPath.row)
    }
}
extension HomeVM {
    
    func getWeather(){
        callNetwork.getWeather(endPoint: .weather, lat: lat ?? "" , lon: lon ?? "") { [weak self] (model) in
            guard let self = self else {return}
            self.model = model
            self.showLoading = false
            self.loadCoreData()
            self.delegate?.getWeather()
        }
    }
}
 //MARK: CoreDataFunc
extension HomeVM {
    
    func save() {
        let weatherItem = WeatherArray(context: self.coreDataModel)
        weatherItem.weatherDegree =  model?.main?.temp?.kelvinToCelcius()
        weatherItem.date = Date().getDateWithTimeZone()        
        guard let id = model?.id else { return }
        let int64ID = Int64(id)
        weatherItem.id = int64ID
        weatherItem.day = Date().getTodayName()
       
        coreDataArray.insert(weatherItem, at: 0)
        
        saveData()
    }
    func saveData() {
        do {
            try coreDataModel.save()
        } catch {
            print("Error saving context \(error)")
        }
        delegate?.saveToDatabase()
    }
    func loadCoreData() {
        let request: NSFetchRequest<WeatherArray> = WeatherArray.fetchRequest()
        do {
            coreDataArray = try coreDataModel.fetch(request)
            coreDataArray = coreDataArray.reversed()
        } catch {
              print("Error loading data \(error)")
        }
    }
}
