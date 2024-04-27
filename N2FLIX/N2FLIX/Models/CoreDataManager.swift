//
//  CoreDataManager.swift
//  N2FLIX
//
//  Created by SAMSUNG on 4/26/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    //  static var saveProduct : [Product] = []
    var persistent : NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    func saveUser(userData: UserData) {
        //    DataManager.saveProduct.append(product)
        guard let context = self.persistent?.viewContext else {return}
        let newPd = User(context: context)
        newPd.userEmail = userData.userEmail
        newPd.userPW = userData.userPW
        newPd.userNickName = "Guest"
        try? context.save()
    }
    
    func readUser() -> [UserData] {
        var read : [UserData] = []
        guard let context = self.persistent?.viewContext else
        { return []}
        let request = User.fetchRequest()
        let loadData = try? context.fetch(request)
        for i in loadData! {
            read.append(UserData(userEmail: i.userEmail!, userPW: i.userPW!, userNickName: i.userNickName!))
        }
        return read
    }
    
    //  func deleteUser(num : Int) {
    //    guard let context = self.persistent?.viewContext else
    //    { return }
    //    let request = User.fetchRequest()
    //    guard let loadData = try? context.fetch(request) else {return}
    //    let filtered = loadData[num]
    //    context.delete(filtered)
    //    try? context.save()
    //  }
    
    func saveReservation(reservationData: ReserveTicket) {
  //    DataManager.saveProduct.append(product)
      guard let context = self.persistent?.viewContext else {return}
      let newPd = Reservation(context: context)
      newPd.totalPrice = Int64(reservationData.totalPrice)
      newPd.dataTime = reservationData.dataTime
      newPd.title = reservationData.title
      newPd.posterPath = reservationData.posterPath
      try? context.save()
    }
      
    func readReservation() -> [ReserveTicket] {
      var read : [ReserveTicket] = []
      guard let context = self.persistent?.viewContext else
      { return []}
      let request = Reservation.fetchRequest()
      let loadData = try? context.fetch(request)
      for i in loadData! {
          read.append(ReserveTicket(dataTime: i.dataTime!, totalPrice: Int(i.totalPrice), title: i.title!, posterPath: i.posterPath!))
      }
      return read
    }
      
    func deleteReservation(num : Int) {
      guard let context = self.persistent?.viewContext else
      { return }
      let request = Reservation.fetchRequest()
      guard let loadData = try? context.fetch(request) else {return}
      let filtered = loadData[num]
      context.delete(filtered)
      try? context.save()
    }
    
    func saveWish(myWish: UserWish) {
  //    DataManager.saveProduct.append(product)
      guard let context = self.persistent?.viewContext else {return}
      let newPd = Wish(context: context)
      newPd.id = Int64(myWish.id)
      newPd.title = myWish.title
      newPd.posterPath = myWish.posterPath
      try? context.save()
    }
      
    func readWish() -> [UserWish] {
      var read : [UserWish] = []
      guard let context = self.persistent?.viewContext else
      { return []}
      let request = Wish.fetchRequest()
      let loadData = try? context.fetch(request)
      for i in loadData! {
          read.append(UserWish(title: i.title!, posterPath: i.posterPath!, id: Int(i.id)))
      }
      return read
    }
      
    func deleteWish(num : Int) {
      guard let context = self.persistent?.viewContext else
      { return }
      let request = Wish.fetchRequest()
      guard let loadData = try? context.fetch(request) else {return}
      let filtered = loadData[num]
      context.delete(filtered)
      try? context.save()
    }
}
