//
//  ConnectivityManagerProtocol.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//


import Foundation
import Network
import Combine

protocol ConnectivityManagerProtocol {
    var status: AnyPublisher<Bool, Never> {get}
    var isConnected: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}

final class ConnectivityManager: ConnectivityManagerProtocol {
    static let shared: ConnectivityManagerProtocol = ConnectivityManager()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    var isConnected: Bool = false

    @Published private var statusPublisher: Bool = false
    var status: AnyPublisher<Bool, Never> {
        $statusPublisher.dropFirst().removeDuplicates().eraseToAnyPublisher()
    }
    private init() {}

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            self.isConnected = path.status == .satisfied
            statusPublisher = self.isConnected
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}

