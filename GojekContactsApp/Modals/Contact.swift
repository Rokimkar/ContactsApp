//
//  Contact.swift
//  GojekContactsApp
//
//  Created by S@nchit on 20/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

class Contact: Codable{
    var id : Int?
    var firstName : String?
    var lastName : String?
    var profilePicture : String?
    var favorite : Bool?
    var url : String?
    var email: String?
    var phoneNumber: String?
    var createdAt: String?
    var updatedAt: String?
    
    init() {
        
    }
    
    enum CodingKeys : String,CodingKey{
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicture = "profile_pic"
        case favorite = "favorite"
        case url = "url"
        case email = "email"
        case phoneNumber = "phone_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(id, forKey: .id)
        try? container.encode(firstName, forKey: .firstName)
        try? container.encode(lastName, forKey: .lastName)
        try? container.encode(profilePicture, forKey: .profilePicture)
        try? container.encode(favorite, forKey: .favorite)
        try? container.encode(url, forKey: .url)
        try? container.encode(email, forKey: .email)
        try? container.encode(phoneNumber, forKey: .phoneNumber)
        try? container.encode(createdAt, forKey: .createdAt)
        try? container.encode(updatedAt, forKey: .updatedAt)
    }
    
    required init(decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        firstName = try? container.decode(String.self, forKey: .firstName)
        lastName = try? container.decode(String.self, forKey: .lastName)
        profilePicture = try? container.decode(String.self, forKey: .profilePicture)
        favorite = try? container.decode(Bool.self, forKey: .favorite)
        url = try? container.decode(String.self, forKey: .url)
        email = try? container.decode(String.self, forKey: .email)
        phoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        createdAt = try? container.decode(String.self, forKey: .createdAt)
        updatedAt = try? container.decode(String.self, forKey: .updatedAt)
    }
}
