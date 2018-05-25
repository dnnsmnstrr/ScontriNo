//
//  Consts.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//funzionerà?

import UIKit

enum Difficulty {
    case easy, normal
}

enum Position {
    case initial, central
}

struct Consts {
    private static let words = [
        Difficulty.easy: [
            Position.initial: [
                "a": ["ape", "addio", "ago", "abbaglio", "addurre", "affetto", "avuto", "aghi", "aglio", "ascia"],
                "e": ["evviva"],
                "ɛ": [],
                "i": [],
                "o": [],
                "ɔ": ["oca", "ocche"],
                "u": ["uffa", "uva", "uno", "urra", "uscio"],
                "b": ["bello", "babbo", "banana", "balena", "beghe", "buchi", "bagno", "biglia", "biscia"],
                "d": ["dado", "dottore", "doglie"],
                "dz": ["zorro"],
                "dʒ": [],
                "f": ["fata", "famoso", "femmina", "fichi", "foglia", "figlio"],
                "g": ["gatto", "gufo", "gattino", "ghiaccio", "ghisa", "gogna"],
                "k": ["cane", "corro", "cappotto", "cotone", "codino", "colore", "cofano", "cassetta", "cannone", "collana", "corona", "correre", "chicco", "chilo", "chele", "coscia"],
                "l": ["leggo", "lana", "leccare", "legare", "lagna", "legno", "luglio", "liscio"],
                "ʎ": [],
                "m": ["moto", "mucca", "mago", "mamma", "mela", "mattone", "mobile", "maghi", "maglia", "moglie"],
                "ɱ": [],
                "n": ["nido", "neve", "nave", "nonno", "nobile"],
                "ŋ": [],
                "ɲ": ["gnomo", "gnocco"],
                "p": ["pipa", "pippo", "pozzo", "pezzo", "palla", "panino", "posate", "piaghe", "poche", "pugno", "pegno", "paglia", "pesce"],
                "r": ["roba", "rosa", "razzo", "rosso", "ricamo", "rumore", "roghi", "raglia"],
                "s": ["sole", "sasso", "seme", "sapone", "sabato", "salame", "seghe", "spighe", "segno", "sogni"],
                "ʃ": ["scimmia", "scialle", "scelta", "sciarpa"],
                "t": ["topo", "tetto", "tavolo", "timone", "toghe"],
                "ts": ["zozzo"],
                "tʃ": [],
                "v": ["vaso", "vagone", "valore"],
                "w": [],
                "j": [],
                "z": [],
            ],
            Position.central: [
                "a": [],
                "e": ["ape"],
                "ɛ": [],
                "i": ["addio"],
                "o": ["addio", "ago"],
                "ɔ": [],
                "u": [],
                "b": [],
                "d": ["addio"],
                "dz": [],
                "dʒ": [],
                "f": [],
                "g": ["ago"],
                "k": [],
                "l": [],
                "ʎ": [],
                "m": [],
                "ɱ": [],
                "n": [],
                "ŋ": [],
                "ɲ": [],
                "p": ["ape"],
                "r": [],
                "s": [],
                "ʃ": [],
                "t": [],
                "ts": [],
                "tʃ": [],
                "v": [],
                "w": [],
                "j": [],
                "z": []
            ]
        ],
        Difficulty.normal: [
            Position.initial: [
                "a": [],
                "e": [],
                "ɛ": [],
                "i": [],
                "o": [],
                "ɔ": [],
                "u": [],
                "b": [],
                "d": [],
                "dz": [],
                "dʒ": [],
                "f": [],
                "g": [],
                "k": [],
                "l": [],
                "ʎ": [],
                "m": [],
                "ɱ": [],
                "n": [],
                "ŋ": [],
                "ɲ": [],
                "p": [],
                "r": [],
                "s": [],
                "ʃ": [],
                "t": [],
                "ts": [],
                "tʃ": [],
                "v": [],
                "w": [],
                "j": [],
                "z": []
            ],
            Position.central: [
                "a": [],
                "e": [],
                "ɛ": [],
                "i": [],
                "o": [],
                "ɔ": [],
                "u": [],
                "b": [],
                "d": [],
                "dz": [],
                "dʒ": [],
                "f": [],
                "g": [],
                "k": [],
                "l": [],
                "ʎ": [],
                "m": [],
                "ɱ": [],
                "n": [],
                "ŋ": [],
                "ɲ": [],
                "p": [],
                "r": [],
                "s": [],
                "ʃ": [],
                "t": [],
                "ts": [],
                "tʃ": [],
                "v": [],
                "w": [],
                "j": [],
                "z": []
            ]
        ]
    ]
    static let shapes = [
        "triangle",
        "star",
        "circle",
        "square",
        "polygon",
        "rounded"
    ]
    static let colors = [
        "blue",
        "green",
        "orange",
        "red",
        "teal blue",
        "yellow"
    ]
    
    
    struct CategorizationGameScreen {
        static let categories = [
            "animals",
            "fruits"
        ]
        static let animals = [
            "bear",
            "duck"
        ]
        static let fruits = [
            "apple",
            "orange"
        ]
    }
    struct Graphics {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }
    struct Id {
        struct CarGameScreen {
            static let coloredShapeNode = "100-"
        }
    }
    enum PhysicsMask {
        static let shapeNodes: UInt32 = 0x1 << 1 //2
        static let holeNode: UInt32 = 0x1 << 2 // 4
    }
}
