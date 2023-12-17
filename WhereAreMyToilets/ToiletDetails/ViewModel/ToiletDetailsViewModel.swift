//
//  ToiletDetailsViewModel.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import Foundation

final class ToiletDetailsViewModel {
    private let field: FieldsDTO
    let title = "Details de vos toilettes"
    let description = "Il y a pas beaucoup d'informations supplementaires ici du coup je mets un petit message pour que ca fasse pas trop vide non plus"
    
    init(field: FieldsDTO) {
        self.field = field
    }
    
    func getAddress() -> String {
        return "Addresse de toilettes: \(field.adress ?? "") \(field.district)"
    }
    
    func getSchedule() -> String {
        guard let schedule = field.schedule else {
            return "Nous n'avons pas les horaires d'ouverture pour ces toilettes."
        }
        return "Les horaires d'ouverture: \(schedule)"
    }
    
    func getAccessPrm() -> String {
        guard let accessPrm = field.accessPrm else {
            return "Nous ne savons pas si ses toilettes sont accessible au personne a mobilité reduite"
        }
        return "Accessible pour les personnes a mobilité reduite: \(accessPrm)"
    }    
}
