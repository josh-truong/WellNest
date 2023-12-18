//
//  GeoConnectView.swift
//  WellNest
//
//  Created by Joshua Truong on 10/10/23.
//

import SwiftUI
import MapKit

struct GeoConnectView: View {
    @Namespace var mapScope
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    @ObservedObject private var vm: GeoConnectViewModel = .init()
    
    @State private var searchText = ""
    @State private var selectedLocation: MKMapItem?
    @State private var showDetails: Bool = false
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var showEdit: Bool = false
    
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selectedLocation) {
            Annotation("My location", coordinate: .userLocation) {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blue.opacity(0.25))
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.blue)
                }
            }
            

            ForEach(vm.publishedResults, id: \.self) { item in
                if routeDisplaying {
                    if item == selectedLocation {
                        let placemark = item.placemark
                        Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    }
                } else {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
            }
            
            if let route = vm.publishedRoute {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 6)
            }
        }
        
        .overlay(alignment: .top) {
            TextField("", text: $searchText, prompt: Text("Search here").foregroundStyle(.gray))
                .font(.subheadline)
                .padding(12)
                .background(.white)
                .foregroundStyle(.black)
                .padding()
                .shadow(radius:10)
        }
        .onSubmit {
            Task { await vm.searchLocation(searchText) }
        }
        .onChange(of: getDirections) { oldValue, newValue in
            if let selectedLocation, newValue {
                Task {
                    await vm.fetchRoute(from: MKMapItem(placemark: MKPlacemark(coordinate: .userLocation)), to: selectedLocation)
                    
                    withAnimation(.snappy) {
                        routeDisplaying = true
                        showDetails = false
                        
                        if let rect = vm.publishedRoute?.polyline.boundingMapRect, routeDisplaying {
                            cameraPosition = .rect(rect)
                        }
                    }
                }
            }
        }
        .onChange(of: selectedLocation, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            GeoLocationDetailsView(mapSelection: $selectedLocation, show: $showDetails, getDirections: $getDirections)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        })
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
            MapScaleView()
        }
        .toolbar {
            ToolbarItem {
                Button("edit", action: { showEdit.toggle() })
            }
        }
        .sheet(isPresented: $showEdit) {
            RecordEntitySlider(activity: Steps(), min: 0, max: 20000)
                .presentationDetents([.height(200)])
                .presentationCornerRadius(12)
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 25.7602, longitude: -80.1959)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
