//
//  LocationManager.swift
//  XAMDiaryManager
//
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    public static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var geoCoder = CLGeocoder()
    weak var locationDelegate: LocationManagerDelegate?
    
    func getLocation() {
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
        locationManager.stopUpdatingLocation()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
        }
        guard let currentLocation = self.currentLocation else {
            print("Unable to reverse-geocode location.")
            return
        }
        geoCoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
            if let error = error {
                print(error)
            }
            guard let placemark = placemarks?.first else { return }
            print(placemark)
            guard let streetNumber = placemark.subThoroughfare else { return }
            guard let streetName = placemark.thoroughfare else { return }
            guard let city = placemark.locality else { return }
            guard let state = placemark.administrativeArea else { return }
            guard let zipCode = placemark.postalCode else { return }
                    
            // 4
            DispatchQueue.main.async {
                let completedAddress = "\(streetNumber) \(streetName) \n \(city), \(state) \(zipCode)"
                print(completedAddress)
                self.locationDelegate?.didReceiveAddress(completedAddress)
            }
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            Utilities.showGenericOkAlert(title: "Background Location Access Disabled",
                                         message: "In order to get the best user experience, please open this app's settings and set location access to 'While Using the App'.") { action in
                if #available(iOS 10.0, *) {
                    let settingsURL = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                } else {
                    if let url = NSURL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.openURL(url as URL)
                    }
                }
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            Utilities.showGenericOkAlert(title: "Error",
                                         message: "Cannot access user location. Please make sure location services is enabled on the app settings.") { action in
                if #available(iOS 10.0, *) {
                    let settingsURL = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                } else {
                    if let url = NSURL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.openURL(url as URL)
                    }
                }
            }
        default:
            break
        }
    }
}

protocol LocationManagerDelegate: AnyObject {
    func didReceiveAddress(_ address: String)
}
