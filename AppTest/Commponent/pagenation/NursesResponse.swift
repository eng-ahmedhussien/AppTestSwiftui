//
//  NursesResponse.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 22/05/2025.
//
import Foundation

struct NursesResponse: Decodable {
    let status: Int
    let message: String
    let data: NursesData
}

struct NursesData: Decodable {
    let items: [Nurse]
    let totalCount: Int
    let pageNumber: Int
    let pageSize: Int
    let totalPages: Int
    let count: Int
    let hasNextPage: Bool
    let hasPreviousPage: Bool
}

struct Nurse: Identifiable, Decodable {
    let id: String
    let fullName: String
    let specialization: String
    let specializationId: Int
    let licenseNumber: String
    let image: String
    let rating: Double?
    let latitude: String
    let longitude: String
}

extension Nurse {
    static var mockData: [Nurse] {
        [
            Nurse(
                id: "1",
                fullName: "Aya Mohsen",
                specialization: "ممرضة أطفال",
                specializationId: 2,
                licenseNumber: "123456",
                image: "https://via.placeholder.com/150",
                rating: 4.5,
                latitude: "29.962696",
                longitude: "31.276942"
            ),
            Nurse(
                id: "2",
                fullName: "Mohamed Yasser",
                specialization: "ممرضة العناية المركزة",
                specializationId: 1,
                licenseNumber: "654321",
                image: "https://via.placeholder.com/150",
                rating: 4.2,
                latitude: "30.05661",
                longitude: "31.330108"
            ),
            Nurse(
                id: "3",
                fullName: "Mai Helmy",
                specialization: "ممرضة أورام",
                specializationId: 3,
                licenseNumber: "123789",
                image: "https://via.placeholder.com/150",
                rating: 4.0,
                latitude: "30.05661",
                longitude: "31.330108"
            ),  Nurse(
                id: "1",
                fullName: "Aya Mohsen",
                specialization: "ممرضة أطفال",
                specializationId: 2,
                licenseNumber: "123456",
                image: "https://via.placeholder.com/150",
                rating: 4.5,
                latitude: "29.962696",
                longitude: "31.276942"
            ),
            Nurse(
                id: "2",
                fullName: "Mohamed Yasser",
                specialization: "ممرضة العناية المركزة",
                specializationId: 1,
                licenseNumber: "654321",
                image: "https://via.placeholder.com/150",
                rating: 4.2,
                latitude: "30.05661",
                longitude: "31.330108"
            ),
            Nurse(
                id: "3",
                fullName: "Mai Helmy",
                specialization: "ممرضة أورام",
                specializationId: 3,
                licenseNumber: "123789",
                image: "https://via.placeholder.com/150",
                rating: 4.0,
                latitude: "30.05661",
                longitude: "31.330108"
            )
        ]
    }
}
