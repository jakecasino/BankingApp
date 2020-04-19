//
//  MapView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/3/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let address: String?
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        guard let address = address else { return }
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                // handle no location found
                return
            }
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            view.setRegion(region, animated: true)
        }
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(address: "6201 Hollywood Blvd, Los Angeles, CA, 90028")
    }
}
