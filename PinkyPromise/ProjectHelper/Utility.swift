//
//  Utility.swift
//  CollectionApp
//
//  Created by MACBOOK on 17/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import SDWebImage
import Toast_Swift
import SafariServices
import Foundation
import EventKit
import MapKit

extension UIView {
    //MARK: - addBorderColorWithCornerRadius
    func addBorderColorWithCornerRadius(borderColor: CGColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

//MARK:- toJson
func toJson(_ dict:[String:Any]) -> String{
    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString!
}

//MARK: - getCurrentTimeStampValue
func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}

//MARK: - DataExtension
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }

}

//MARK:- Delay Features
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

//MARK:- Toast
func displayToast(_ message:String)
{
    UIApplication.topViewController()?.view.makeToast(message)
}


func displayToastWithDelay(_ message:String)
{
    delay(0.2) {
        UIApplication.topViewController()?.view.makeToast(getTranslate(message))
    }
}


//MARK:- Image Function
func compressImageView(_ image: UIImage, to toSize: CGSize) -> UIImage {
    var actualHeight: Float = Float(image.size.height)
    var actualWidth: Float = Float(image.size.width)
    let maxHeight: Float = Float(toSize.height)
    //600.0;
    let maxWidth: Float = Float(toSize.width)
    //800.0;
    var imgRatio: Float = actualWidth / actualHeight
    let maxRatio: Float = maxWidth / maxHeight
    //50 percent compression
    if actualHeight > maxHeight || actualWidth > maxWidth {
        if imgRatio < maxRatio {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight
            actualWidth = imgRatio * actualWidth
            actualHeight = maxHeight
        }
        else if imgRatio > maxRatio {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = maxWidth
        }
        else {
            actualHeight = maxHeight
            actualWidth = maxWidth
        }
    }
    let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    let imageData1: Data? = img?.jpegData(compressionQuality: 1.0)//UIImageJPEGRepresentation(img!, CGFloat(1.0))//UIImage.jpegData(img!)
    UIGraphicsEndImageContext()
    return  imageData1 == nil ? image : UIImage(data: imageData1!)!
}

//MARK:- Loader
func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}

// MARK: - removeLoader
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}

//Image Compression to 10th
func compressImage(image: UIImage) -> Data {
    // Reducing file size to a 10th
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1920.0
    let maxWidth : CGFloat = 1080.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionQuality : CGFloat = 0.5
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if (imgRatio < maxRatio) {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        } else {
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: compressionQuality)
    UIGraphicsEndImageContext();
    return imageData!
}

func showAlert(_ title:String, message:String, completion: @escaping () -> Void) {
    let myAlert = UIAlertController(title:NSLocalizedString(title, comment: ""), message:NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
    myAlert.view.tintColor = AppColor
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{ (action) in
        completion()
    })
    myAlert.addAction(okAction)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

func showAlertWithOption(_ title:String, message:String, btns:[String] ,completionConfirm: @escaping () -> Void,completionCancel: @escaping () -> Void){
    let myAlert = UIAlertController(title:NSLocalizedString(title, comment: ""), message:NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
    let rightBtn = UIAlertAction(title: NSLocalizedString(btns[0], comment: ""), style: UIAlertAction.Style.default, handler: { (action) in
        completionCancel()
    })
    let leftBtn = UIAlertAction(title: NSLocalizedString(btns[1], comment: ""), style: UIAlertAction.Style.cancel, handler: { (action) in
        completionConfirm()
    })
    myAlert.addAction(rightBtn)
    myAlert.addAction(leftBtn)
    AppDelegate().sharedDelegate().window?.rootViewController?.present(myAlert, animated: true, completion: nil)
}

//func showAlertPopup(_ title:String, message:String, completion: @escaping () -> Void) {
//    let vc : AlertViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "AlertViewVC") as! AlertViewVC
//    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
//    vc.setupDetails(title, message)
//    
//    vc.fullBtn.addAction {
//        vc.view.removeFromSuperview()
//        completion()
//    }
//}

func openMapForPlace(_ lat : Double, _ long: Double, _ address: String) {
    let latitude: CLLocationDegrees = lat
    let longitude: CLLocationDegrees = long

    let regionDistance:CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    let options = [
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = address
    mapItem.openInMaps(launchOptions: options)
}

//MARK: - downloadCachedImage
extension UIImageView{
    func downloadCachedImage(placeholder: String,urlString: String){
        //self.sainiShowLoader(loaderColor:  #colorLiteral(red: 0.06274509804, green: 0.1058823529, blue: 0.2235294118, alpha: 1))
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType,_ ) in
            //self.sainiRemoveLoader()
            guard image != nil else {
                //self.sainiRemoveLoader()
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                //self.sainiRemoveLoader()
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                //self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
    
    func downloadImage(placeholder: String,urlString: String){
        //self.sainiShowLoader(loaderColor:  #colorLiteral(red: 0.06274509804, green: 0.1058823529, blue: 0.2235294118, alpha: 1))
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType,_ ) in
            //self.sainiRemoveLoader()
            guard image != nil else {
                //self.sainiRemoveLoader()
                return
            }
//            guard cacheType != .memory, cacheType != .disk else {
//                self.image = image
//                //self.sainiRemoveLoader()
//                return
//            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                //self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
}

//MARK: - height of a label
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    //MARK: - isValidEmail
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

//MARK: - displaySubViewtoParentView
func displaySubViewtoParentView(_ parentview: UIView! , subview: UIView!)
{
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func getTranslate(_ str : String) -> String
{
    return NSLocalizedString(str, comment: "")
}

//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}

//MARK:- UICollectionView
extension UICollectionView {
   //MARK:- setEmptyMessage
   public func sainiSetEmptyMessageCV(_ message: String) {
       let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
       messageLabel.text = message
       messageLabel.textColor = .black
       messageLabel.numberOfLines = 0;
       messageLabel.textAlignment = .center;
       messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
       messageLabel.sizeToFit()
       self.backgroundView = messageLabel;
    
   }
   //MARK:- sainiRestore
   public func restore() {
       self.backgroundView = nil
       
   }
}

func getBeforeTimeInMinute(_ index: Int) -> Int {
    switch index {
    case 0:
        return 5
    case 1:
        return 10
    case 2:
        return 15
    case 3:
        return 30
    case 4:
        return 60
    case 5:
        return 1440
    default:
        return 0
    }
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

//MARK:- Get Json from file
func getJsonFromFile(_ file : String) -> [[String : Any]]
{
    if let filePath = Bundle.main.path(forResource: file, ofType: "json"), let data = NSData(contentsOfFile: filePath) {
        do {
            if let json : [[String : Any]] = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String : Any]] {
                return json
            }
        }
        catch {
            //Handle error
        }
    }
    return [[String : Any]]()
}

// MARK: - getCompleteString
func getCompleteString(strArr: [String]) -> String {
    var str: String = String()
    for i in 0..<strArr.count {
        if i == strArr.count - 1 {
            str += strArr[i]
        }
        else {
            str += (strArr[i]) + ", "
        }
    }
    return str
}

//MARK: - Add event in to default calender
//Give info.plist permission "Privacy - Calendars Usage Description"
//import EventKit
func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, url: String, beforTime: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    DispatchQueue.global(qos: .background).async { () -> Void in
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                if url != "" {
                    event.url = URL(string: url)
                }
                event.calendar = eventStore.defaultCalendarForNewEvents
                
//                let maxDate : Date = Calendar.current.date(byAdding: .minute, value: -getBeforeTimeInMinute(beforTime), to: startDate)!
                event.alarms = [EKAlarm.init(absoluteDate: beforTime)]
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    print("failed to save event with error : \(error)")
                    completion?(false, e)
                    return
                }
                print("Saved Event")
                completion?(true, nil)
            } else {
                print("failed to save event with error : \(error) or access not granted")
                completion?(false, error as NSError?)
            }
        })
    }
}

func showDatePicker(title : String, selected: Date?,  minDate : Date?, maxDate : Date?, completionDone: @escaping (_ date : Date) -> Void, completionClose: @escaping () -> Void){
    
    let vc : DatePickerViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "DatePickerViewVC") as! DatePickerViewVC
    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
    vc.setupDatePickerDetails(title: title, selected: selected, minDate: minDate, maxDate: maxDate)
    
    vc.closeBtn.addAction {
        vc.view.removeFromSuperview()
        completionClose()
    }
    vc.doneBtn.addAction {
        vc.view.removeFromSuperview()
        completionDone(vc.datePicker.date)
    }
}

func showHelpUsPopup() {
    delay(5) {
        let vc : HelpMoreVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "HelpMoreVC") as! HelpMoreVC
        displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
        
        vc.closeBtn.addAction {
            vc.view.removeFromSuperview()
        }
        vc.shareBtn.addAction {
            vc.view.removeFromSuperview()
            setIsShareApp(isUserLogin: true)
            shareText(UIApplication.topViewController() ?? vc, shareAppMessage)
        }
    }
}

//func showBadgesPopup() {
//    delay(0.2) {
//        let vc : BadgesPopupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "BadgesPopupVC") as! BadgesPopupVC
//        displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
//
//        vc.closeBtn.addAction {
//            vc.view.removeFromSuperview()
//        }
//    }
//}

func showBadgesPopup(badgeImg:String, title:String, bottomDesc:String, isCoin: Bool,completionCancel: @escaping () -> Void){
    let vc : BadgesPopupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "BadgesPopupVC") as! BadgesPopupVC
    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
    vc.setupDetails(badgeImg, title, bottomDesc, isCoin)

    vc.closeBtn.addAction {
        vc.viewHideFromBackView(isCoin)

        delay(2) {
            vc.view.removeFromSuperview()
            completionCancel()
        }
    }
}


func showTimePicker(title : String, selected: Date?, completionDone: @escaping (_ date : Date) -> Void, completionClose: @escaping () -> Void){
    
    let vc : DatePickerViewVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "DatePickerViewVC") as! DatePickerViewVC
    displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: vc.view)
    vc.setupTimePickerDetails(title: title, selected: selected)
    
    vc.closeBtn.addAction {
        vc.view.removeFromSuperview()
        completionClose()
    }
    vc.doneBtn.addAction {
        vc.view.removeFromSuperview()
        completionDone(vc.datePicker.date)
    }
}

//MARK:- Open Url
func openUrlInSafari(strUrl : String)
{
    if strUrl.trimmed == "" {
        return
    }
    
    let webUrl = strUrl
    if webUrl.hasPrefix("https://") || webUrl.hasPrefix("http://"){
        guard let url = URL(string: webUrl) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }else {
        let correctedURL = "http://\(webUrl)"
        let escapedAddress = correctedURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let url = URL(string: escapedAddress ?? "") else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK:- Share
func shareText(_ vc:UIViewController, _ text:String)
{
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = vc.view
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
    vc.present(activityViewController, animated: true, completion: nil)
}

//Get year array
func getYearArr() -> [String] {
    var yearArr : [String] = [String]()
    for i in 0...30 {
        let fromDate = Calendar.current.date(byAdding: .year, value: i, to: Date())
        yearArr.append(getDateStringFromDate1(date: fromDate!, format: "yyyy"))
    }
    return yearArr
}

class L102Language {
/// get current Apple language
    class func currentAppleLanguage() -> String
    {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        if current == "" {
            return "en"
        }
        return current
    }
    
    // set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    class var isRTL: Bool {
        return L102Language.currentAppleLanguage() == "hi"
    }
}

//MARK:- Email
func redirectToEmail(_ email : String)
{
    if email == "" || !email.isValidEmail {
        displayToast("Invalid email address")
        return
    }
    guard let url = URL(string: "mailto:\(email)") else {
        displayToast("Invalid email address")
        return
    }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
    } else {
        UIApplication.shared.openURL(url)
    }
}

func getDoubleValueOfDistance(_ price : Double) -> String {
    return "\(String(format: "%.1f", price))km"
}

func getLabelArray(_ label : [String]) -> String {
    return label.joined(separator: ", ")
}

func isLocationAccessEnabled() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            return true
        default:
            break
        }
    } else {
        print("Location services not enabled")
        return false
    }
    return false
}

func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double, label: UILabel) {
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    let ceo: CLGeocoder = CLGeocoder()
    center.latitude = pdblLatitude
    center.longitude = pdblLongitude
    var addressString : String = ""
    
    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

    ceo.reverseGeocodeLocation(loc, completionHandler:
        {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]

            if pm.count > 0 {
                let pm = placemarks![0]
                print(pm.country)
                print(pm.locality)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.postalCode)
                print(pm.subThoroughfare)
                
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                print(addressString)
                label.text = addressString
          }
    })
}

//MARK:- Attribute string
func attributedStringWithColor(_ mainString : String, _ strings: [String], color: UIColor, font: UIFont? = nil) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: mainString)
    for string in strings {
        let range = (mainString as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        if font != nil {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font!, range: range)
        }
    }
    return attributedString
}

//MARK:- Reminder
//func setReminder() {
//    self.SOGetPermissionCalendarAccess()
//}
//
//
//func SOGetPermissionCalendarAccess() {
//    switch EKEventStore.authorizationStatus(for: .event) {
//        case .authorized:
//            printData("Authorised")
//            addReminder()
//            break
//        case .denied:
//            printData("Access denied")
//            break
//        case .notDetermined:
//            eventStore.requestAccess(to: .event, completion:
//                {(granted, error) in
//                    if !granted {
//                        printData("Access to store not granted")
//                        self.addReminder()
//                    }
//            })
//            break
//        default:
//            printData("Case Default")
//    }
//}
//
//func addReminder()
//{
//    if let tempDate = getDateFromDateString(strDate: auction.auction_end, format: "YYYY-MM-dd") {
//        var reminderDate = tempDate
//        if hour24Btn.isSelected {
//            reminderDate = Calendar.current.date(byAdding: .hour, value: -24, to: tempDate)!
//        }
//        else if hour48Btn.isSelected {
//            reminderDate = Calendar.current.date(byAdding: .hour, value: -48, to: tempDate)!
//        }
//        else if hour72Btn.isSelected {
//            reminderDate = Calendar.current.date(byAdding: .hour, value: -72, to: tempDate)!
//        }
//        let event:EKEvent = EKEvent(eventStore: eventStore)
//        event.title = auction.auction_title
//        event.startDate = reminderDate
//        event.endDate = reminderDate
//        event.calendar = eventStore.defaultCalendarForNewEvents
//        do {
//            try eventStore.save(event, span: .thisEvent)
//            setNewReminder(auction.auctionid, event.eventIdentifier)
//            self.hour24Btn.isSelected = false
//            self.hour48Btn.isSelected = false
//            self.hour72Btn.isSelected = false
//        } catch let e as NSError {
//            printData(e.description)
//            return
//        }
//    }
//}
//
//func deleteReminder()
//{
//    let tempData = getReminderData()
//    if tempData[auction.auctionid] == nil {
//        return
//    }
//    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
//        eventStore.requestAccess(to: .event, completion: { (granted, error) -> Void in
//            self.deleteEvent(eventStore: self.eventStore, eventIdentifier: tempData[self.auction.auctionid] as! String)
//        })
//    } else {
//        self.deleteEvent(eventStore: eventStore, eventIdentifier: tempData[auction.auctionid] as! String)
//    }
//}
//
//func deleteEvent(eventStore: EKEventStore, eventIdentifier: String) {
//    let eventToRemove = eventStore.event(withIdentifier: eventIdentifier)
//    if (eventToRemove != nil) {
//        do {
//            try eventStore.remove(eventToRemove!, span: .thisEvent, commit: true)
//            try eventStore.remove(eventToRemove!, span: .futureEvents, commit: true)
//            printData("Remove")
//        } catch {
//            printData(error.localizedDescription)
//        }
//    }
//}



func createFolderInDocumentDirectory() -> URL {
    let DocumentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    let DirPath = DocumentDirectory.appendingPathComponent("PinkyPromise")
    do
    {
        try FileManager.default.createDirectory(atPath: DirPath!.path, withIntermediateDirectories: true, attributes: nil)
    }
    catch let error as NSError
    {
        print("Unable to create directory \(error.debugDescription)")
    }
    print("Dir Path = \(DirPath!)")
    return DirPath!
}

func savePdf(urlString:String, fileName:String, tid: Int) {
    DispatchQueue.main.async {
        let urlNew:String = urlString.replacingOccurrences(of: " ", with: "%20").trimmed
        let url = URL(string: urlNew)
        if url == nil {
            return
        }
        
        var getPdfName = urlNew.components(separatedBy: "/")
        let pdfData = try? Data.init(contentsOf: url!)
        let resourceDocPath = createFolderInDocumentDirectory() //(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let pdfNameFromUrl = "PinkyPromise-\(fileName).pdf"
        
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try pdfData?.write(to: actualPath, options: .atomic)
            print("Final Path = \(actualPath)")
            
            if getTopicDataArrayData() != nil {
                let topicArr = getTopicDataArrayData()
                if topicArr?.count != 0 {
                    
                    let index = topicArr?.firstIndex(where: { (data) -> Bool in
                        data.tid == tid
                    })
                    if index != nil {
                        AppDelegate().sharedDelegate().scheduleLocalNotification(topicArr?[index!].topic ?? "PinkyPromise", actualPath, pdfNameFromUrl)
                    }
                    else{
                        AppDelegate().sharedDelegate().scheduleLocalNotification(getPdfName.count != 0 ? getPdfName[getPdfName.count - 2] : "PinkyPromise",actualPath, pdfNameFromUrl)
                    }
                }
            }
            else{
                AppDelegate().sharedDelegate().scheduleLocalNotification(getPdfName.count != 0 ? getPdfName[getPdfName.count - 2] : "PinkyPromise",actualPath, pdfNameFromUrl)
            }
            
            
            print("pdf successfully saved!")
        } catch {
            print("Pdf could not be saved")
        }
    }
}

func showSavedPdf(url:String, fileName:String) {
    if #available(iOS 10.0, *) {
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            for url in contents {
                if url.description.contains("\(fileName).pdf") {
                    // its your file! do what you want with it!
                }
            }
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
    }
}

// check to avoid saving a file multiple times
func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
    var status = false
    if #available(iOS 10.0, *) {
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            for url in contents {
                if url.description.contains("PinkyPromise-\(fileName).pdf") {
                    status = true
                }
            }
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
    }
    return status
}

