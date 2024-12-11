//
//  BoriGameView.swift
//  el_wa
//
//  Created by Dianelys Saldaña on 12/1/24.
//

import Foundation
import SwiftUI

struct BoriGameView: View {
    
    let frasesBoricuas = [
        "Pasteles", "Mofongo", "Malta", "Church's", "Don Frappe", "Limber",
        "Coquito", "Arroz chino", "El Mesón", "Alcapurria", "Ricomini", "Mojito",
        "Helado de parcha y coco", "Bacalaitos", "Bad Bunny", "Jovani Vazquez",
        "Ricky Roselló", "Mayagüez", "Ponce", "San Juan", "El Poblado", "Wepa", "Janguear",
        "Boricua", "Nítido", "Acicalao", "Revolú", "Bembé", "Chévere", "Corillo", "Bochinche",
        "Al garete", "Perreo", "Guagua", "Chavos", "Chiringa", "Brutal", "Acho", "Pichea", "Guillao",
        "Tostones", "Arroz con gandules", "Pernil", "Tembleque", "Flan", "Sorullitos", "Asopao",
        "Empanadillas", "Pan sobao", "Arroz mamposteao", "Piña colada", "Coquito", "Coquí", "Flor de Maga",
        "El Yunque", "El Morro", "Trovador", "Fiestas de San Sebastián", "Fiestas Patronales", "Bomba", "Plena",
        "Capicú", "Pelea de gallos", "Salsa", "Reguetón", "Cuatro puertorriqueño", "Guayabera", "Aguinaldos",
        "Chancletas", "Hamaca", "Pitorro", "Ron", "Vieques", "Culebra"
    ]
    
    @StateObject private var motionManager = MotionManager()
    @State private var currentPhrase: String?
    @State private var score = 0
    @State private var timeRemaining = 60
    @State private var backgroundColor = Color.yellow
    @Environment(\.presentationMode) var presentationMode
    
    let colorCycle: [Color] = [.yellow, .red, .green, .blue]
    @State private var colorIndex = 0

    var body: some View {
        ZStack {
            // Background color
            backgroundColor
                .ignoresSafeArea()
            
            // Main content area
            VStack {
                Spacer()

                if let phrase = currentPhrase {
                    Text(phrase)
//                        .font(.largeTitle)
                        .font(.system(size: 66))
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    Text("Get Ready!")
                        .font(.largeTitle)
                        .padding()
                }

                Spacer()
            }

            // Time at the top-right corner
            VStack {
                HStack {
                    Spacer()
                    Text("\(timeRemaining)s")
                        .font(.title)
                        .padding(.top, 10)
                        .padding(.trailing, 15)
                }
                Spacer()
            }

            // Score at the bottom-right corner
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .font(.title)
                        .padding(.bottom, 10)
                        .padding(.trailing, 15)
                }
            }
        }
        .onAppear {
            currentPhrase = frasesBoricuas.randomElement()
            startTimer()
            motionManager.startMotionUpdates()
        }
        .onChange(of: motionManager.deviceTilt) { tilt in
            if tilt == "up" {
                handleCorrectAnswer()
            } else if tilt == "down" {
                handlePass()
            }
        }
        .onDisappear {
            motionManager.stopMotionUpdates()
        }
    }

    func handleCorrectAnswer() {
        score += 1
        currentPhrase = frasesBoricuas.randomElement()
        cycleBackgroundColor()
    }

    func handlePass() {
        currentPhrase = frasesBoricuas.randomElement()
        cycleBackgroundColor()
    }
    
    func cycleBackgroundColor() {
        colorIndex = (colorIndex + 1) % colorCycle.count
        backgroundColor = colorCycle[colorIndex]
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                // DISPLAY "SE ACABÓ LO QUE SE DABA"
            }
        }
    }
}
