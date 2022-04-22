//
//  SharedData.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation
import Alamofire

class SharedData{

    static let SharedInstans = SharedData()
    let defaults = UserDefaults.standard
    let IsLogin = "IsLogin"
    let IsfinishOnBoarding = "FinishOnBoarding"
    let IsActive = "IsActive"
    let Language = "Language"
    let Password = "password"
    let Token = "Token"
    let Name = "userName"
    let UserId = "userId"
    let Email = "email"
    let Phone = "phone"
    let AccountType = "accountType"
    let CoverImagePath = "coverImage"
    let imagePath = "image"
    let Cusidentity = "identity"
    let terms = "Terms"
    let faq = "FAQ"
    let avaliable = "Avaliable"
    let areaId = "AreaID"
    let ShowMap = "ShowMap"
    let vendorId = "VendorId"
    let deliveryCharge = "deliveryCharge"
    let lat = "Lat"
    let long = "Lng"
    let addres = "Address"
    let celebrityId = "Celebrity"
    let areaName = "AreaName"
    let userName = "Name"
    let voucherAmount = "Voucher"
    let fixed = "fixedAmount"
    let couponString = "Coupon"

    func setUserName(_ name:String){
        defaults.set(name, forKey: userName)
    }

    func getUserName()->String{
        if (defaults.object(forKey: userName) != nil) {
            return defaults.string(forKey: userName) ?? ""
        }else{
            return ""
        }
    }

    func setCelebrityId(_ id:Int){
        defaults.set(id, forKey: celebrityId)
    }

    func getCelebrityId() -> Int{
        if (defaults.object(forKey: celebrityId) != nil) {
            return defaults.integer(forKey: celebrityId)
        }else{
            return 0
        }
    }


    func setAreaName(_ name:String){
        defaults.set(name, forKey: areaName)
    }

    func getAreaName()->String{
        if (defaults.object(forKey: areaName) != nil) {
            return defaults.string(forKey: areaName) ?? ""
        }else{
            return ""
        }
    }

    func setLat(_ latit:String){
        defaults.set(latit, forKey: lat)
    }

    func getLat()->String{
        if (defaults.object(forKey: lat) != nil) {
            return defaults.string(forKey: lat) ?? ""
        }else{
            return ""
        }
    }

    func setLng(_ lng:String){
        defaults.set(lng, forKey: long)
    }

    func getLng()->String{
        if (defaults.object(forKey: long) != nil) {
            return defaults.string(forKey: long) ?? ""
        }else{
            return ""
        }
    }

    func setAddress(_ address:String){
        defaults.set(address, forKey: addres)
    }

    func getAddres()->String{
        if (defaults.object(forKey: addres) != nil) {
            return defaults.string(forKey: addres) ?? ""
        }else{
            return ""
        }
    }


    func setDeliveryCharge(_ charge:Double){
        defaults.set(charge, forKey: deliveryCharge)
    }

    func getDeliveryCharge()->Double{
        if (defaults.object(forKey: deliveryCharge) != nil) {
            return defaults.double(forKey: deliveryCharge)
        }else{
            return 0.0
        }
    }

    func setVendorId(_ id:String){
        defaults.set(id, forKey: vendorId)
    }

    func getVendorId()->String{
        if (defaults.object(forKey: vendorId) != nil) {
            return defaults.string(forKey: vendorId) ?? ""
        }else{
            return ""
        }
    }

    func setVoucherAmount(_ amount:Double){
        defaults.set(amount, forKey: voucherAmount)
    }

    func getVoucherAmount()->Double{
        if (defaults.object(forKey: voucherAmount) != nil) {
            return defaults.double(forKey: voucherAmount)
        }else{
            return 0.0
        }
    }

    func setIsFixedAmount(_ isFixed:Bool){
        defaults.set(isFixed, forKey: fixed)
    }

    func getIsFixedAmount()->Bool{
        if (defaults.object(forKey: fixed) != nil) {
            return defaults.bool(forKey: fixed)
        }else{
            return false
        }
    }

    func setCoupon(_ coubon:String){
        defaults.set(coubon, forKey: couponString)
    }

    func getCoupon()->String{
        if (defaults.object(forKey: couponString) != nil) {
            return defaults.string(forKey: couponString) ?? ""
        }else{
            return ""
        }
    }

    func setAreaId(_ id:Int){
        defaults.set(id, forKey: areaId)
    }

    func getAreaId()->Int{
        if (defaults.object(forKey: areaId) != nil) {
            return defaults.integer(forKey: areaId)
        }else{
            return 0
        }
    }

    func SetShowMap(_ showMap:Bool){
        defaults.set(showMap, forKey: ShowMap)
    }

    func GetShowMap()->Bool{
        if (defaults.object(forKey: ShowMap) != nil) {
            return defaults.bool(forKey: ShowMap)
        }else{
            return false
        }
    }

    func SetIsLogin(_ isLogin:Bool){
        defaults.set(isLogin, forKey: IsLogin)
    }

    func GetIsLogin()->Bool{
        if (defaults.object(forKey: IsLogin) != nil) {
            return defaults.bool(forKey: IsLogin)
        }else{
            return false
        }
    }

    func setIsFinishOnboarding(_ finishOnBoarding:Bool){
        defaults.set(finishOnBoarding, forKey: IsfinishOnBoarding)
    }

    func getIsFinishOnboarding()->Bool{
        if (defaults.object(forKey: IsfinishOnBoarding) != nil) {
            return defaults.bool(forKey: IsfinishOnBoarding)
        }else{
            return false
        }
    }

    func SetIsActive(_ isActive:Bool){
        defaults.set(isActive, forKey: IsActive)
    }

    func GetIsActive()->Bool{
        if (defaults.object(forKey: IsActive) != nil) {
            return defaults.bool(forKey: IsActive)
        }else{
            return false
        }
    }

    func setLanguage(_ language:String){
        defaults.set(language, forKey: Language)
    }
    func getLanguage()->String{
        if (defaults.object(forKey: Language) != nil) {
            return defaults.string(forKey: Language)!
        }else{
            return "en"
        }
    }

    func settoken(_ token:String){
        defaults.set(token, forKey: Token)
    }
    func gettoken()->String{
        if (defaults.object(forKey: Token) != nil) {
            return defaults.string(forKey: Token)!
        }else{
            return ""
        }
    }
    func setVendorName(_ userName:String){
        defaults.set(userName, forKey: Name)
    }
    func getVendorNAme()->String{
        if (defaults.object(forKey: Name) != nil) {
            return defaults.string(forKey: Name)!
        }else{
            return ""
        }
    }

    func setPhone(_ phoneNumber:String){
        defaults.set(phoneNumber, forKey: Phone)
    }
    func getphone()->String{
        if (defaults.object(forKey: Phone) != nil) {
            return defaults.string(forKey: Phone)!
        }else{
            return ""
        }
    }

    func setPassWord(_ pass:String){
        defaults.set(pass, forKey: Password)
    }
    func getPassWord()->String{
        if (defaults.object(forKey: Password) != nil) {
            return defaults.string(forKey: Password)!
        }else{
            return " "
        }
    }

    func setEmail(_ userEmail:String){
        defaults.set(userEmail, forKey: Email)
    }
    func getEmail()->String{
        if (defaults.object(forKey: Email) != nil) {
            return defaults.string(forKey: Email)!
        }else{
            return "nil"
        }
    }
    func setUserId(_ userID:String){
        defaults.set(userID, forKey: UserId)
    }
    func getUserId()->String{
        if (defaults.object(forKey: UserId) != nil) {
            return defaults.string(forKey: UserId)!
        }else{
            return " "
        }
    }

    func setVendorImage(_ userImagePath:String){
        defaults.set(userImagePath, forKey: imagePath)
    }
    func getVendorImage()->String{
        if (defaults.object(forKey: imagePath) != nil) {
            return defaults.string(forKey: imagePath)!
        }else{
            return " "
        }
    }

    func setCoverImage(_ coverImagePath:String){
        defaults.set(coverImagePath, forKey: CoverImagePath)
    }
    func getCoverImage()->String{
        if (defaults.object(forKey: CoverImagePath) != nil) {
            return defaults.string(forKey: CoverImagePath)!
        }else{
            return " "
        }
    }

    func setAccountType(_ type:String){
        defaults.set(type, forKey: AccountType)
    }
    func getAccountType()->String{
        if (defaults.object(forKey: AccountType) != nil) {
            return defaults.string(forKey: AccountType)!
        }else{
            return " "
        }
    }

    func setCusidentity(_ cusidentity:String){
        defaults.set(cusidentity, forKey: Cusidentity)
    }
    func getCusidentity()->String{
        if (UserDefaults.standard.object(forKey: Cusidentity) != nil) {
            return defaults.string(forKey: Cusidentity)!
        }else{
            return ""
        }
    }

    func setTermsURL(_ cusidentity:String){
        defaults.set(cusidentity, forKey: terms)
    }
    func getTermsURL()->String{
        if (UserDefaults.standard.object(forKey: terms) != nil) {
            return defaults.string(forKey: terms)!
        }else{
            return ""
        }
    }

    func setFAQURL(_ cusidentity:String){
        defaults.set(cusidentity, forKey: faq)
    }
    func getFAQURL()->String{
        if (UserDefaults.standard.object(forKey: faq) != nil) {
            return defaults.string(forKey: faq)!
        }else{
            return ""
        }
    }

    func setIsAvaliable(_ isAvaliable:Bool){
        defaults.set(isAvaliable, forKey: avaliable)
    }

    func getIsAvaliable()->Bool{
        if (defaults.object(forKey: avaliable) != nil) {
            return defaults.bool(forKey: avaliable)
        }else{
            return false
        }
    }

    func loadAddresses() -> [SavedAddressesModel]{
        let savedAddresses = defaults.decode(for: [SavedAddressesModel].self, using: "Addresses") ?? [SavedAddressesModel]()
        return savedAddresses
    }

    func saveAddresses(savedAddresses: [SavedAddressesModel]) {
        defaults.encode(for: savedAddresses, using: "Addresses")
    }


    func removeUserData(){
        defaults.removeObject(forKey: IsLogin)
        defaults.removeObject(forKey: Name)
        defaults.removeObject(forKey: Email)
        defaults.removeObject(forKey: Phone)
        defaults.removeObject(forKey: AccountType)
        defaults.removeObject(forKey: CoverImagePath)
        defaults.removeObject(forKey: imagePath)
        defaults.removeObject(forKey: UserId)
    }

    func getHeader() -> HTTPHeaders {
        let lang = LanguageManager.isArabic() ? "1" : "0"
        let token = SharedData.SharedInstans.gettoken()
        return HTTPHeaders(["Content-Type":"application/json", "Authorization":"Bearer \(token)", "device": "1", "lang": lang])
    }
}
