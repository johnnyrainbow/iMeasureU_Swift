//
//  Sorting.swift
//  IMeasureUapp
//
//  Created by Gabriel Kennedy on 29/03/19.
//  Copyright © 2019 Gabriel Kennedy. All rights reserved.
//

import Foundation

class Sorting { //Static Util class
    
    static func sort(players: [Player],key: String, ascending: Bool) -> [Player] { //sorts the player list by header key in an ascending or descending order
        //No strict
        let lowerKey = key.lowercased()
       
        if(ascending) {
            return players.sorted(by: { Parser.stringParser(value: $0.attributes[lowerKey]!) < Parser.stringParser(value:$1.attributes[lowerKey]!)
            })
        }
        //descending
        return Player.players.sorted(by: { Parser.stringParser(value: $0.attributes[lowerKey]!) > Parser.stringParser(value:$1.attributes[lowerKey]!)
        })
    }
    
    static func filterQuery(players: [Player], key: String, query: String) -> [Player] {
        //returns a list of players with key value *containing query
        var filterList = [Player]()
        players.forEach { player in
            if(player.attributes[key]!.contains(query)) {
                filterList.append(player)
            }
        }
        return filterList
    }
    
    static func anyKeyFilterQuery(players: [Player],query: String, strict: Bool) -> [Player] {
        //returns a list of players with key value *containing query
        var filterList = [Player]()
        
            players.forEach { player in
            CSVUtil.headerRow.forEach { key in
                //Prevent duplicates
                if !filterList.contains(where: {($0.attributes["number"] == player.attributes["number"])}){
                    
                    if(strict) {
                        if(player.attributes[key.lowercased()]!.contains(query)) {
                            filterList.append(player)
                        }
                    } else {
                        if(player.attributes[key.lowercased()]!.localizedCaseInsensitiveContains(query)) {
                            filterList.append(player)
                        }
                    }
                }
            }
        }
        return filterList
    }
    
    static func filterBounds(key: String, lowerBound: Int, upperBound:Int ) -> [Player] {
        //returns a list of players with values within key value bounds.
        //Does not currently work for dates.
    
        var filterList = [Player]()
        Player.players.forEach { player in
            if(Parser.isInt(string:player.attributes[key]!)) {
                if(Int(player.attributes[key]!)! >= lowerBound && Int(player.attributes[key]!)! <= upperBound) {
                    filterList.append(player)
                }
            }
        }
        return filterList
    }
}
