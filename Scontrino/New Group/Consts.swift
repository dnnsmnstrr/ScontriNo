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
    struct Graphics {
        static let screenBounds = UIScreen.main.bounds
        static let screenWidth = screenBounds.width
        static let screenHeight = screenBounds.height
        static let screenResolution = screenBounds.size
        static let scale = screenWidth / 1336
    }
    private static let words = [
        Difficulty.easy: [
            Position.initial: [
                "a": ["ape", "addio", "ago", "abbaglio", "addurre", "affetto", "avuto", "aghi", "aglio", "ascia"],
                "e": ["evviva"],
                "ɛ": [],
                "i": [],
                "o": [],
                "ɔ": ["oca", "oche"],
                "u": ["uffa", "uva", "uno", "urra", "uscio"],
                "b": ["bello", "babbo", "banana", "balena","buchi", "bagno", "biglia", "biscia"],
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
                "a": ["abbaglio","ascia","evviva","oca","uffa","uva","urra","babbo","banana","bagno","biglia","biscia","dado","fata","famoso","femmina","foglia","gatto","gattino","ghiaccio","ghisa","gogna","cane","cappotto","cofano","cassetta","cassetta","cannone","collana","corona","coscia", "lana","leccare","legare","lagna","mucca","mago","mamma","mela","mattone","maghi","maglia","nave","pipa","palla","panino","posate","piaghe","paglia","roba","rosa","razzo","ricamo","raglia","sasso","sapone","sabato","salame","scimmia","scialle","scelta","sciarpa","tavolo","vaso","vagone","valore"],
                "e": ["ape","addurre","balena","dottore","femmina","correre","chele","leccare","legare","legno","mela","neve","pegno","pesce","seme","seghe","segno","scelta"],
                "ɛ": ["affetto","oche","bello","doglie","cane","cotone","colore","cassetta","cannone","leggo","leccare","legare","mobile","moglie","nave","nobile","pezzo","posate","piaghe","poche","rumore","sole","sapone","salame","spighe","scialle","tetto","timone","toghe","vagone","valore"],
                "i":  ["addio","abbaglio","aghi","aglio","ascia","evviva","uscio","babbo","buchi","biglia","biscia","doglie","femmina","fichi","foglia","figlio","gattino","ghiaccio","ghisa","codino","chicco","chilo","coscia","luglio","liscio","mobile","maghi","maglia","moglie","nido","nobile","pipa","pippo","panino","piaghe","paglia","ricamo","roghi","raglia","spighe","sogni","scimmia","scialle","sciarpa","timone"],
                "o": ["dottore","famoso","foglia","gogna","corro","cotone","codino","colore","cannone","corona","correre","legno","mattone","moglie","pozzo","rosso","rumore","roghi","sole","sapone","tetto","timone","zozzo","vagone","valore"],
                "ɔ": ["addio","ago","abbaglio","affetto","avuto","aglio","uno","uscio","bello","bagno","dado","doglie","zorro","famoso","figlio","gatto","gufo","gattino","ghiaccio","cappotto","codino","cofano","collana","chicco","chilo","coscia","leggo","luglio","liscio","moto","mago","mobile","nido","nonno","nobile","gnomo","gnocco","pippo","pezzo","panino","posate","poche","roba","rosa","razzo","ricamo","sasso","sabato","segno","sogni","topo","tavolo","toghe","vaso"],
                "u": ["addurre","avuto","buchi","gufo","luglio","mucca","pugno","rumore"],
                "b": ["abbaglio","babbo","mobile","nobile","roba","sabato"],
                "d": ["addio","addurre","dado","codino","nido"],
                "dz": [],
                "dʒ": [],
                "f": ["affetto","uffa","gufo"],
                "g": ["ago","aghi","leggo","legare","mago","maghi","piaghe","roghi","seghe","spighe","toghe","vagone"],
                "k": ["oca","buchi","fichi","chicco","leccare","mucca","gnocco","poche","ricamo"],
                "l": ["bello","balena","colore","collana","chilo","chele","mela","mobile","nobile","palla","sole","salame","scialle","scelta","tavolo","valore"],
                "ʎ": ["abbaglio","aglio","biglia","doglie","foglia","figlio","luglio","maglia","moglie","paglia","raglia"],
                "m": ["famoso","femmina","mamma","gnomo","ricamo","rumore","seme","salame","scimmia","timone"],
                "ɱ": [],
                "n": ["uno","banana","balena","femmina","gattino","cane","cotone","codino","cofano","cannone","collana","corona", "lana","mattone","nonno","panino","sapone","timone","vagone"],
                "ŋ": [],
                "ɲ": ["bagno","gogna","lagna","legno","pegno","pugno","segno","sogni"],
                "p": ["ape","cappotto","pipa","pippo","sapone","spighe","sciarpa","topo"],
                "r": ["addurre","urra","dottore","zorro","corro","colore","corona","correre","leccare","legare","rumore","sciarpa","valore"],
                "s": ["famoso","cassetta","posate","rosa","rosso","sasso","vaso"],
                "ʃ": ["ascia","uscio","biscia","coscia","liscio","pesce"],
                "t": ["affetto","avuto","dottore","fata","gatto","gattino","cappotto","cotone","cassetta","moto","mattone","posate","sabato","scelta","tetto"],
                "ts": ["pozzo","pezzo","razzo","zozzo"],
                "tʃ": ["ghiaccio"],
                "v": ["avuto","evviva","uva","neve","nave"],
                "w": [],
                "j": [],
                "z": ["ghisa"]
            ]
        ],
        Difficulty.normal: [
            Position.initial: [
                "a": ["anello","abbaglio"],
                "e": [],
                "ɛ": [],
                "i": [],
                "o": [],
                "ɔ": [],
                "u": [],
                "b": ["bagnato","bagliore"],
                "d": [],
                "dz": [],
                "dʒ": [],
                "f": ["fachiro","falegname"],
                "g": ["ghermire","ghepardo","gheriglio"],
                "k": ["chimera","chinare","cognome","cognato","coniglio","coscienza","cuscino"],
                "l": ["legname"],
                "ʎ": [],
                "m": ["maglione","maniglia"],
                "ɱ": [],
                "n": ["nascita"],
                "ŋ": [],
                "ɲ": [],
                "p": ["panchina","paghetta","pugnale","pagnotta","piscina","prosciutto"],
                "r": ["ruscello"],
                "s": ["schiena","scherma","schiavo","sfregio","sfratto","spugna","strano","straccio","strappo","strada","strato","stretta","struzzo","strutto","screzio","scrigno","scroscio","sprazzo","spreco","spruzzo","signora","sognato","sogliola","sciacallo","sceriffo","sciopero"],
                "ʃ": [],
                "t": ["tovaglia","tagliare"],
                "ts": [],
                "tʃ": [],
                "v": [],
                "w": [],
                "j": [],
                "z": []
            ],
            Position.central: [
                "a": ["abbaglio","bagnato","bagliore","fachiro","falegname","ghepardo","chimera","chinare","cognato","coscienza","legname","maglione","maniglia","nascita","panchina","paghetta","pugnale","pagnotta","piscina","schiena","schiavo","sfratto","spugna","strano","straccio","strappo","strada","strato","stretta","sprazzo","signora","sognato","sogliola","sciacallo","tovaglia","tagliare"],
                "e": ["ghermire","ghepardo","legname","maglione","scherma","stretta",],
                "ɛ": ["anello","bagliore","falegname","ghermire","gheriglio","chimera","chinare","cognome","coscienza","legname","paghetta","pugnale","ruscello","schiena","sfregio","screzio","spreco","sceriffo","sciopero","tagliare"],
                "i": ["abbaglio","bagliore","fachiro","gheriglio","chimera","chinare","coniglio","coscienza","cuscino","maglione","maniglia","nascita","panchina","piscina","prosciutto","schiavo","sfregio","straccio","screzio","scrigno","scroscio","signora","sogliola","sciacallo","sceriffo","sciopero","tagliare"],
                "o": ["bagliore","maglione","signora","sognato"],
                "ɔ": ["anello","abbaglio","bagnato","fachiro","ghepardo","gheriglio","cognome","cognato","coniglio","coscienza","cuscino","pagnotta","prosciutto","sfratto","strano","straccio","strappo","strato","struzzo","screzio","scrigno","scroscio","sprazzo","spreco","spruzzo","sogliola","sciacallo","sciopero","tovaglia"],
                "u": ["cuscino","pugnale","prosciutto","ruscello","schiavo","sfregio","spugna","struzzo","strutto","spruzzo"],
                "b": ["abbaglio"],
                "d": ["ghepardo","strada"],
                "dz": [],
                "dʒ": ["sfregio"],
                "f": ["sfregio","sfratto","sceriffo"],
                "g": ["paghetta"],
                "k": ["fachiro","panchina","schiena","scherma","schiavo","scrigno","scroscio","spreco","sciacallo"],
                "l": ["anello","pugnale","ruscello","sogliola","sciacallo"],
                "ʎ": ["abbaglio","bagliore","gheriglio","coniglio","maglione","maniglia","sogliola","tovaglia","tagliare"],
                "m": ["falegname","ghermire","cognome","legname","pugnale","scherma"],
                "ɱ": [],
                "n": ["anello","chinare","cuscino","maglione","maniglia","panchina","piscina","schiena","strano"],
                "ŋ": [],
                "ɲ": ["bagnato","cognome","cognato","legname","pugnale","pagnotta","spugna","scrigno","signora","sognato"],
                "p": ["ghepardo","spugna","strappo","sprazzo","spreco","spruzzo","sciopero"],
                "r": ["fachiro","ghermire","ghepardo","gheriglio","chimera","chinare","prosciutto","scherma","sfregio","sfratto","strano","strappo","strada","strato","stretta","struzzo","scrigno","scroscio","spreco","spruzzo","signora","sceriffo","sciopero","tagliare"],
                "s": [],
                "ʃ": ["coscienza","cuscino","nascita","piscina","prosciutto","ruscello","scroscio"],
                "t": ["bagnato","falegname","cognato","nascita","paghetta","pagnotta","prosciutto","sfratto","strano","straccio","strappo","strada","strato","stretta","struzzo","strutto","sognato"],
                "ts": ["coscienza","struzzo","screzio","sprazzo","spruzzo"],
                "tʃ": ["straccio"],
                "v": ["schiavo","tovaglia"],
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
    
    
    struct FloatingLogsGameScreen {
        static let categories = [
            "animals",
            "fruits",
            "clothes"
        ]
        static let animals = [
            "bear",
            "duck",
            "dog"
        ]
        static let fruits = [
            "apple",
            "orange",
            "lime"
        ]
        static let clothes = [
            "shirt",
            "dress"
        ]
    }
    struct Id {
        struct RollerCoasterGameScreen {
            static let coloredShapeNode = "100-"
        }
    }
    enum PhysicsMask {
        static let shapeNodes: UInt32 = 0x1 << 1 //2
        static let holeNode: UInt32 = 0x1 << 2 // 4
    }
    
    struct NodePositions {
        static let movingCategInitialPos = CGPoint(x: Graphics.screenWidth / 2 , y: 0 - Graphics.screenHeight / 6)
        static let movingCategFinalPos = CGPoint(x: Graphics.screenWidth / 2 , y: Graphics.screenHeight / 6)
        
        static let firstLogPosition = CGPoint(x: Graphics.screenWidth / 4 , y: Graphics.screenHeight / 2)
        
        static let secondLogPosition = CGPoint(x: (3 * Graphics.screenWidth) / 4 , y: Graphics.screenHeight / 2)
        
    }
    
}
