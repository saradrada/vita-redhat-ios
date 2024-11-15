//
//  WebsocketMessageHandler.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 27.10.24.
//

import Foundation
import Combine

class WebSocketMessageHandler {
    private var webSocketTask: URLSessionWebSocketTask?
    private let urlString: String
    weak var glucoseChartViewModel: GlucoseChartViewModel?

    init(urlString: String) {
        self.urlString = urlString
    }

    func startListening() {
        guard webSocketTask == nil else { return }
        connectWebSocket()
    }

    func stopListening() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
    }

    private func connectWebSocket() {
        guard let url = URL(string: urlString) else { return }
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        listenForMessages()
    }

    private func listenForMessages() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket error: \(error)")
                self?.reconnect()
            case .success(let message):
                switch message {
                case .data(let data):
                    self?.handleIncomingData(data)
                case .string(let text):
                    if let data = text.data(using: .utf8) {
                        self?.handleIncomingData(data)
                    }
                @unknown default:
                    fatalError()
                }
                self?.listenForMessages()
            }
        }
    }

    private func handleIncomingData(_ data: Data) {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let type = jsonObject["type"] as? String {
                switch type {
                case "glucose_data":
                    if let jsonStrings = jsonObject["data"] as? [String] {
                        let newGlucoseData = try jsonStrings.map { jsonString -> GlucoseData in
                            guard let jsonData = jsonString.data(using: .utf8) else {
                                throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Unable to convert string to data"))
                            }
                            return try JSONDecoder().decode(GlucoseData.self, from: jsonData)
                        }
                        DispatchQueue.main.async { [weak self] in
                            print("Updating glucoseChartViewModel with new data.")
                            self?.glucoseChartViewModel?.updateGlucoseData(with: newGlucoseData)
                        }
                    }
                case "alert":
                    if let alertDataString = jsonObject["data"] as? String,
                       let alertData = alertDataString.data(using: .utf8) {
                        let alert = try JSONDecoder().decode(GlucoseAlertData.self, from: alertData)
                        DispatchQueue.main.async {
                            GlucoseAlertViewModel.shared.handleAlert(alert: alert)
                        }
                    }
                default:
                    print("Unhandled message type: \(type)")
                }
            }
        } catch {
            print("Failed to decode WebSocket data: \(error)")
        }
    }

    private func reconnect() {
        stopListening()
        startListening()
    }
}
